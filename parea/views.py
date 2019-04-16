from django.contrib import messages
from django.contrib.auth import get_user_model
from django.shortcuts import render
from django.urls import reverse_lazy
from django.views.generic import CreateView

from .forms import RegisterForm



UserModel = get_user_model()


class RegisterView(CreateView):
    model = UserModel
    template_name = 'registration/register.html'
    form_class = RegisterForm
    success_url = reverse_lazy('auth:login')
    success_message = 'Account was successfuly registered.'


    def form_valid(self, form):
        messages.success(self.request, self.success_message)

        return super().form_valid(form)
