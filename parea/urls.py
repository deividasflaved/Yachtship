"""
Create your urls here
"""

from django.urls import path

from .views import RegisterView
from .views import APILoginView

app_name = 'parea'

urlpatterns = [
    path('register', RegisterView.as_view(), name='register'),
    path('loginAPI/', APILoginView.as_view(), name='loginAPI'),
]
