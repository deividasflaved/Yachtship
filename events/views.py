"""
Your main classes and functions goes here
"""
import json


from datetime import date
from datetime import datetime
from datetime import timedelta

from django.contrib.auth.models import Permission, Group
from django.core.serializers import serialize
from django.contrib.auth.mixins import LoginRequiredMixin
# from django.views.decorators.csrf import csrf_exempt
# from django.utils.decorators import method_decorator
from django.core.serializers.json import DjangoJSONEncoder
from django.utils.timezone import get_current_timezone
from django.utils import timezone

from django.http import HttpResponse, HttpResponseRedirect
# from django.http import HttpResponseRedirect
from django.http import JsonResponse
from django.urls import reverse
from django.urls import reverse_lazy

from django.shortcuts import render
from django.shortcuts import redirect
from django.shortcuts import get_object_or_404

from django.views.generic import CreateView
from django.views.generic import DeleteView
from django.views.generic import DetailView
from django.views.generic import ListView
from django.views.generic import UpdateView
from django.views.generic import View

# from django.forms import modelformset_factory
from django.forms import inlineformset_factory

from .forms import CompetitionForm
from .forms import RaceForm
from .forms import TeamForm
from .forms import TestForm
from .forms import RaceFormAPI
from .forms import ResultTableEntry

from .models import Event
from .models import Race
from .models import Competition
from .models import GpsCoordinates
from .models import Team
from .models import ResultTable


# Create your views here.

# @method_decorator(csrf_exempt, name='dispatch')
class APIGpsCoordinatesView(LoginRequiredMixin, View):
    """
    API for saving user gps coordinates
    """
    model = GpsCoordinates

    def get(self, request, *args, **kwargs):
        """
        Custom get function
        """
        print(request.user.user_referee.all())
        data = {'test': request.user.username}
        return JsonResponse(data, safe=False)

    def post(self, request, *args, **kwargs):
        """
        Custom post function
        """
        form = TestForm(request.POST, request.FILES)
        # data = {
        #     # 'csrf_token': get_token(request),# generate csrf token or get from somewhere
        #     # 'session_id': request.session.session_key,
        #     # 'username'  : request.user.username
        #     'status': 'success'
        # }
        if form.is_valid():
            server_datetime = datetime.now(tz=get_current_timezone())
            client_datetime = datetime.strptime(request.POST['time'], '%Y-%m-%d %H:%M:%S.%f')
            client_datetime = timezone.make_aware(client_datetime)
            if client_datetime > server_datetime:
                if (client_datetime - server_datetime) > timedelta(seconds=5):
                    best_datetime = client_datetime
                else:
                    best_datetime = server_datetime
            else:
                if (server_datetime - client_datetime) > timedelta(seconds=5):
                    best_datetime = client_datetime
                else:
                    best_datetime = server_datetime

            form.instance.time = best_datetime
            form.instance.team = get_object_or_404(Team, id=request.POST['team_id'])

            form.save()
            return HttpResponse(status=204)

        return HttpResponse(status=204)


class APIGpsCoordinatesPointsView(LoginRequiredMixin, View):
    """
    API for referee to save gps coordinates of checkpoint start and finish
    """
    model = Race

    def get(self, request, *args, **kwargs):
        """
        Custom get function
        """
        data = {'test': request.user.username}
        return JsonResponse(data, safe=False)

    def post(self, request, *args, **kwargs):
        """
        Custom post function
        """
        # TODO think of a way to pass pk from android APP pylint: disable=fixme
        race = get_object_or_404(self.model, pk=5)
        form = RaceFormAPI(request.POST, instance=race)
        if form.is_valid():
            form.save()
        else:
            print(form.errors)

        return HttpResponse(status=204)


class APIResultTableEntry(LoginRequiredMixin, View):
    """
    API for saving results of race
    """
    model = ResultTable

    def get(self, request, *args, **kwargs):
        """
        Custom get function
        """
        data = {'test': request.user.username}
        return JsonResponse(data, safe=False)

    def post(self, request, *args, **kwargs):
        """
        Custom post functions
        """
        # race=get_object_or_404(self.model, pk=1)
        form = ResultTableEntry(request.POST)
        if form.is_valid():
            form.save()
        else:
            print(form.errors)

        return HttpResponse(status=204)


class ReplayView(View):
    """
    Race replay class
    """
    model = GpsCoordinates
    model_event = Event
    model_competition = Competition
    model_race = Race
    template_name = 'replay.html'

    def get(self, request, *args, **kwargs):
        """
        Custom get method
        """
        # queryset = self.model.objects.all()

        race = get_object_or_404(self.model_race, pk=kwargs['pk'])
        competition = get_object_or_404(self.model_competition, pk=kwargs['competition'])
        event = get_object_or_404(self.model_event, pk=competition.event_id)
        teams = event.teams.all()
        coordinates = self.model.objects.filter(time__range=[race.start_date, race.start_date + race.duration])
        data = list(self.model.objects.values())
        race_data = {
            'start': race.start_coordinates,
            'finish': race.finish_coordinates,
            'checkpoint': race.checkpoint_coordinates,
            'referee': race.referee_coordinates,
            'start_date': race.start_date
        }
        context = {
            'coordinates': json.dumps(data, cls=DjangoJSONEncoder), #Testavimui veliau istrinti
            # 'coordinates': json.dumps(list(coordinates.values()), cls=DjangoJSONEncoder),
            'teams': json.dumps(list(teams.values())),
            'race': json.dumps(race_data, cls=DjangoJSONEncoder)
        }
        # print(race.start_date)
        # js_data = serializers.serialize('json', queryset)
        # js_data = js_data.replace('\\"', "\"")
        # json.loads(js_data)
        return render(request, self.template_name, context)


class ReplayData(View):
    """
    Race replay class
    """
    model = GpsCoordinates

    # template_name = 'home1.html'

    def get(self, request, *args, **kwargs):
        """
        Custom get method
        """
        # queryset = self.model.objects.all()
        data = list(self.model.objects.values())
        # js_data = serializers.serialize('json', queryset)
        # js_data = js_data.replace('\\"', "\"")
        # json.loads(js_data)
        return JsonResponse(data, safe=False)


class EventListView(ListView):  # pylint: disable=too-many-ancestors
    """
    Returns events list
    """
    model = Event
    paginate_by = 6

    def get_queryset(self):
        queryset = super().get_queryset()
        return queryset.filter(event_date__year=date.today().year)


class EventOlderListView(EventListView):  # pylint: disable=too-many-ancestors
    """
    Returns older events list
    """

    def get_queryset(self):
        queryset = ListView.get_queryset(self)
        return queryset.exclude(event_date__year=date.today().year)


class EventDetailView(DetailView):  # pylint: disable=too-many-ancestors
    """
    Returns chosen event details
    """
    model = Event

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        if self.request.user.is_authenticated:
            context['team'] = self.request.user.user_teams.all().filter(event=self.object)
        return context


class EventCreateView(LoginRequiredMixin, CreateView):  # pylint: disable=too-many-ancestors
    """
    Creates new event
    """
    model = Event
    fields = ['title', 'event_date', 'description', 'image']
    template_name = 'events/event_form.html'
    success_url = reverse_lazy('events:list')

    def get(self, request, *args, **kwargs):
        """
        Custom get function
        """
        if request.user.has_perm('events.add_event'):
            return super().get(request, *args, **kwargs)
        return HttpResponseRedirect(self.success_url)


class EventDeleteView(LoginRequiredMixin, DeleteView):  # pylint: disable=too-many-ancestors
    """
    Deletes selected event
    """
    model = Event
    success_url = reverse_lazy('events:list')

    def get(self, request, *args, **kwargs):
        """
        Custom get function
        """
        if request.user.has_perm('events.delete_event'):
            return super().get(request, *args, **kwargs)
        return HttpResponseRedirect(self.success_url)


class EventUpdateView(LoginRequiredMixin, View):
    """
    Updates selected event
    """
    model = Competition
    model_event = Event
    form_class = CompetitionForm
    fields = ['title', 'start_date']
    extra = 1

    def get(self, request, *args, **kwargs):
        """
        Custom get function
        """
        if request.user.has_perm('events.change_event'):
            competition_form_set = inlineformset_factory(
                self.model_event, self.model, form=self.form_class, fields=self.fields, extra=self.extra
            )
            event = self.model_event.objects.get(pk=kwargs['pk'])
            formset = competition_form_set(instance=event)

            return render(request, 'competitions/competition_form.html', {'formset': formset})

        return redirect('events:detail', kwargs['pk'])

    def post(self, request, *args, **kwargs):
        """
        Custom post function
        """
        competition_form_set = inlineformset_factory(
            self.model_event, self.model, form=self.form_class, fields=self.fields, extra=self.extra
        )
        event = self.model_event.objects.get(pk=kwargs['pk'])
        formset = competition_form_set(
            request.POST, request.FILES, prefix='competitions', instance=event
        )

        if formset.is_valid():
            formset.save()
            return redirect('events:detail', event.id)

        return render(request, 'competitions/competition_form.html', {'formset': formset})


class RaceUpdateView(LoginRequiredMixin, UpdateView):  # pylint: disable=too-many-ancestors
    """
    Updates selected race
    """
    model = Race
    form_class = RaceForm
    template_name = 'races/race_form.html'
    success_url = 'events:competition_detail'

    def get(self, request, *args, **kwargs):
        """
        Custom get function
        """
        if request.user.has_perm('events.change_race'):
            return super().get(request, *args, **kwargs)
        return redirect('events:competition_detail', kwargs['competition'])

    def post(self, request, *args, **kwargs):
        """
        Custom get function
        """
        if request.user.has_perm('events.change_race'):
            return super().post(request, *args, **kwargs)
        return redirect('events:competition_detail', kwargs['competition'])

    def get_success_url(self):
        competition_pk = self.kwargs.get('competition')

        return reverse(self.success_url, kwargs={'pk': competition_pk})


class CompetitionDetailView(DetailView):  # pylint: disable=too-many-ancestors
    """
    Returns selected competition details
    """
    model = Competition
    template_name = 'competitions/competition_detail.html'


class CompetitionDeleteView(LoginRequiredMixin, DeleteView):  # pylint: disable=too-many-ancestors
    """
    Deletes selected competition
    """
    # TODO Check if this class is needed pylint: disable=fixme
    model = Competition
    success_url = reverse_lazy('competitions:competition_detail')


class TeamCreateView(LoginRequiredMixin, CreateView):  # pylint: disable=too-many-ancestors
    """
    Creates new team
    """
    model = Team
    model_event = Event
    form_class = TeamForm
    pk_url_kwarg = 'event'
    success_url = 'events:detail'

    def get(self, request, *args, **kwargs):
        """
        Custom get function
        """
        if request.user.has_perm('events.add_team'):
            if kwargs['event'] not in request.user.user_teams.all().values_list('event_id', flat=True):
                return super().get(request, *args, **kwargs)
        return redirect('events:detail', kwargs['event'])

    def post(self, request, *args, **kwargs):
        """
        Custom get function
        """
        if request.user.has_perm('events.add_team'):
            if kwargs['event'] not in request.user.user_teams.all().values_list('event_id', flat=True):
                return super().post(request, *args, **kwargs)
        return redirect('events:detail', kwargs['event'])

    def form_valid(self, form):
        user = self.request.user
        event_pk = self.kwargs.get(self.pk_url_kwarg)
        form.instance.event = get_object_or_404(self.model_event, pk=event_pk)
        form.instance.user = self.request.user

        group_basic = Group.objects.get(name='Basic')
        group_participant = Group.objects.get(name='Participant')
        if user.groups.all():
            if user.groups.all()[0].name == 'Basic':
                group_basic.user_set.remove(user)
                group_participant.user_set.add(user)

        return super().form_valid(form)

    def get_success_url(self):
        event_pk = self.kwargs.get(self.pk_url_kwarg)

        return reverse(self.success_url, kwargs={'pk': event_pk})


class RaceCreateView(LoginRequiredMixin, CreateView):  # pylint: disable=too-many-ancestors
    """
    Returns selected competition details
    """
    model = Race
    model_competition = Competition
    form_class = RaceForm
    pk_url_kwarg = 'competition'
    template_name = 'races/race_form.html'
    success_url = 'events:competition_detail'

    def get(self, request, *args, **kwargs):
        """
        Custom get function
        """
        if request.user.has_perm('events.add_race'):
            return super().get(request, *args, **kwargs)
        return redirect('events:competition_detail', kwargs['competition'])

    def post(self, request, *args, **kwargs):
        """
        Custom get function
        """
        if request.user.has_perm('events.add_race'):
            return super().post(request, *args, **kwargs)
        return redirect('events:competition_detail', kwargs['competition'])

    def form_valid(self, form):
        competition_pk = self.kwargs.get(self.pk_url_kwarg)
        form.instance.competition = get_object_or_404(self.model_competition, pk=competition_pk)
        # form.instance.user = self.request.user
        form.instance.duration = timedelta(minutes=10) #Default value 10 minutes
        print(form)
        return super().form_valid(form)

    def get_success_url(self):
        competition_pk = self.kwargs.get(self.pk_url_kwarg)

        return reverse(self.success_url, kwargs={'pk': competition_pk})


class TeamUpdateView(LoginRequiredMixin, UpdateView):  # pylint: disable=too-many-ancestors
    """
    Updates selected team
    """
    model = Team
    model_event = Event
    form_class = TeamForm
    success_url = 'events:detail'

    def get(self, request, *args, **kwargs):
        """
        Custom get function
        """
        if request.user.has_perm('events.change_team'):
            if kwargs['event'] in request.user.user_teams.all().values_list('event_id', flat=True):
                if get_object_or_404(self.model, pk=kwargs['pk']).user_id == self.request.user.id:
                    return super().get(request, *args, **kwargs)
        return redirect('events:detail', kwargs['event'])

    def post(self, request, *args, **kwargs):
        """
        Custom get function
        """
        if request.user.has_perm('events.change_team'):
            if kwargs['event'] in request.user.user_teams.all().values_list('event_id', flat=True):
                if get_object_or_404(self.model, pk=kwargs['pk']).user_id == self.request.user.id:
                    return super().post(request, *args, **kwargs)
        return redirect('events:detail', kwargs['event'])

    def get_success_url(self):
        event_pk = self.kwargs.get('event')

        return reverse(self.success_url, kwargs={'pk': event_pk})
