from datetime import date
from datetime import datetime
from datetime import timedelta

from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator

from django.http import HttpResponseRedirect
from django.urls import reverse
from django.urls import reverse_lazy
from django.http import JsonResponse

from django.shortcuts import render
from django.shortcuts import redirect
from django.shortcuts import get_object_or_404


from django.views.generic import CreateView
from django.views.generic import DeleteView
from django.views.generic import DetailView
from django.views.generic import ListView
from django.views.generic import UpdateView
from django.views.generic import View


from django.forms import modelformset_factory
from django.forms import inlineformset_factory
from .forms import CompetitionForm
from .forms import RaceForm
from .forms import TeamForm
from .forms import TestForm


from .models import Event
from .models import Competition
from .models import Race
from .models import Team
from .models import GpsCoordinates
# Create your views here.

@method_decorator(csrf_exempt, name='dispatch')
class GpsCoordinatesView(View):
    model = GpsCoordinates

    
    def post(self, request, *args, **kwargs):
        form = TestForm(request.POST, request.FILES)
        data = {
        'latitude': request.POST['latitude'],
        'longitude': request.POST['longitude'],
        'team_name': request.POST['team_name']
    }
        if form.is_valid():
            server_datetime = datetime.now()
            client_datetime = datetime.strptime(request.POST['time'], '%Y-%m-%d %H:%M:%S.%f')

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
            form.instance.team = get_object_or_404(Team, team_name=request.POST['team_name'])

            form.save()
            return JsonResponse(data)
        else:
            print(form.errors)       
        
        return JsonResponse(data)
# @csrf_exempt
# def profile(request):
#     form = TestForm()
#     form = TestForm(request.POST)
#     if form.is_valid():
#         form.save()
#     data = {
#         'latitude': 'request.POST[\'latitude\']',
#         'longitude': 'request.POST[\'longtitude\']'
#     }
#     return JsonResponse(data)


class EventListView(LoginRequiredMixin, ListView):
    model = Event
    paginate_by = 6

    def get_queryset(self):
        queryset = super().get_queryset()
        return queryset.filter(event_date__year=date.today().year)

class EventOlderListView(EventListView):
    
    def get_queryset(self):
        queryset = ListView.get_queryset(self)  
        return queryset.exclude(event_date__year=date.today().year)

class EventDetailView(LoginRequiredMixin, DetailView):
    model = Event
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['team'] = self.request.user.user_teams.all().filter(event=self.object)
        return context
 

class EventCreateView(LoginRequiredMixin, CreateView):
    model = Event
    fields = ['title', 'event_date', 'description', 'image']
    success_url = reverse_lazy('events:list')

class EventDeleteView(LoginRequiredMixin, DeleteView):
    model = Event
    success_url = reverse_lazy('events:list')

class CoordinatesCreateView(CreateView):
    model = GpsCoordinates
    fields = ['latitude', 'longtitude']

class EventUpdateView(LoginRequiredMixin, View):
    model = Competition
    model_event = Event
    form_class = CompetitionForm
    fields = ['title','start_date']
    extra = 1

    def get(self, request, *args, **kwargs):
        CompetitionFormSet = inlineformset_factory(self.model_event, self.model, form=self.form_class,fields=self.fields, extra=self.extra)        
        event = self.model_event.objects.get(pk=kwargs['pk'])
        formset = CompetitionFormSet(instance=event)

        return render(request, 'competitions/competition_form.html', {'formset': formset})


    def post(self, request, *args, **kwargs):
        CompetitionFormSet = inlineformset_factory(self.model_event, self.model, form=self.form_class,fields=self.fields, extra=self.extra)        
        event = self.model_event.objects.get(pk=kwargs['pk'])
        formset = CompetitionFormSet(request.POST, request.FILES, prefix='competitions', instance=event)
        
        if formset.is_valid():
            formset.save()
            return redirect('events:detail', event.id)
        else:
            print(formset.errors)       
        
        return render(request, 'competitions/competition_form.html', {'formset': formset})

        

class CompetitionsUpdateView(LoginRequiredMixin, UpdateView):
    model = Competition
    fields = ['title']
    success_url = 'events:detail'


class RaceUpdateView(LoginRequiredMixin, UpdateView):
    model = Race
    form_class = RaceForm
    template_name = 'races/race_form.html'
    success_url = 'events:competition_detail'

    def get_success_url(self):
        competition_pk = self.kwargs.get('competition')

        return reverse(self.success_url, kwargs={'pk': competition_pk})

        

        

class CompetitionDetailView(LoginRequiredMixin, DetailView):
    model = Competition
    template_name = 'competitions/competition_detail.html'
    
class CompetitionDeleteView(LoginRequiredMixin, DeleteView):
    model = Competition
    success_url = reverse_lazy('competitions:competition_detail')
   
class TeamCreateView(LoginRequiredMixin, CreateView):
    model = Team
    model_event = Event
    form_class = TeamForm
    pk_url_kwarg = 'event'
    success_url = 'events:detail'

    def form_valid(self, form):
        event_pk = self.kwargs.get(self.pk_url_kwarg)
        form.instance.event = get_object_or_404(self.model_event, pk=event_pk)
        form.instance.user = self.request.user

        return super().form_valid(form)


    def get_success_url(self):
        event_pk = self.kwargs.get(self.pk_url_kwarg)

        return reverse(self.success_url, kwargs={'pk': event_pk})

class RaceCreateView(LoginRequiredMixin, CreateView):
    model = Race
    model_competition = Competition
    form_class = RaceForm
    pk_url_kwarg = 'competition'
    template_name = 'races/race_form.html'
    success_url = 'events:competition_detail'

    def form_valid(self, form):
        competition_pk = self.kwargs.get(self.pk_url_kwarg)
        form.instance.competition = get_object_or_404(self.model_competition, pk=competition_pk)
        form.instance.user = self.request.user

        return super().form_valid(form)


    def get_success_url(self):
        competition_pk = self.kwargs.get(self.pk_url_kwarg)

        return reverse(self.success_url, kwargs={'pk': competition_pk})

class TeamUpdateView(LoginRequiredMixin, UpdateView):
    model = Team
    form_class = TeamForm
    success_url = 'events:detail'

    def get_success_url(self):
        event_pk = self.kwargs.get('event')
        
        return reverse(self.success_url, kwargs={'pk': event_pk})

