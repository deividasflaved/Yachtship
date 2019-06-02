"""
Place your views and other functions here
"""
from datetime import datetime
from django.contrib import messages
from django.contrib.auth import get_user_model
from django.contrib.auth import authenticate
from django.contrib.auth import login as auth_login
from django.contrib.auth.models import Group
# , logout as auth_logout
from django.contrib.auth.forms import AuthenticationForm

from django.urls import reverse_lazy
from django.http import JsonResponse

from django.views.generic import CreateView
from django.views.generic import FormView

from django.middleware.csrf import get_token

from events.models import Competition
from events.models import Team
from .forms import RegisterForm

USERMODEL = get_user_model()


class APILoginView(FormView):
    """
    API class for login
    """
    template_name = 'auth/login.html'
    authentication_form = AuthenticationForm
    redirect_authenticated_user = True
    model_competition = Competition
    model_team = Team

    def get(self, request, *args, **kwargs):
        data = {
            'csrf_token': get_token(request)  # generate csrf token or get from somewhere
        }
        return JsonResponse(data, status=200)

    def post(self, request, *args, **kwargs):
        username = request.POST['username']
        password = request.POST['password']
        date = datetime.today().strftime('%Y-%m-%d')
        user = authenticate(username=username, password=password)

        if user is not None:
            auth_login(request, user)
            data = {
                'csrf_token': get_token(request),  # generate csrf token or get from somewhere
                'session_id': request.session.session_key
            }
        else:
            return JsonResponse({'success': 'fail'}, status=401)
        try:
            competition = self.model_competition.objects.get(start_date=date)
            data['competition_id'] = competition.id
            event = competition.event
            try:
                team = self.model_team.objects.get(user=self.request.user, event=event)
                data['team_id'] = team.id
            except self.model_team.DoesNotExist:
                data['team_id'] = None
            for comp in request.user.user_referee.all():
                if comp == competition:
                    data['is_referee'] = 'true'
                    return JsonResponse(data)
            data['is_referee'] = 'false'
        except self.model_competition.DoesNotExist:
            data['competition_id'] = competition.id
            data['team_id'] = None
            data['is_referee'] = None
        return JsonResponse(data)

    def form_valid(self, form):
        """Security check complete. Log the user in."""
        auth_login(self.request, form.get_user())

        user_data = {
            'user': 'admin'  # add user if needed or export to separate API call
        }

        return JsonResponse(user_data, status=200)


class RegisterView(CreateView):  # pylint: disable=too-many-ancestors
    """
    Class for registration
    """
    model = USERMODEL
    template_name = 'registration/register.html'
    form_class = RegisterForm
    success_url = reverse_lazy('auth:login')
    success_message = 'Account was successfuly registered.'

    def form_valid(self, form):
        messages.success(self.request, self.success_message)
        user = form.save()

        basic_group = Group.objects.get(name='Basic')
        user.groups.add(basic_group)

        # user.save()
        return super().form_valid(form)
