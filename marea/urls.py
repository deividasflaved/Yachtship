"""
Create your urls here
"""

from django.contrib.auth.decorators import login_required
from django.urls import path
from django.views.generic import TemplateView
from events.views import EventListView




app_name = 'marea'


urlpatterns = [
    path('', EventListView.as_view(), name='home'),
    path('home1', login_required(TemplateView.as_view(template_name='marea/home1.html')),
         name='home1'),
]
