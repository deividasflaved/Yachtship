"""
Place your urls of events here
"""

from django.urls import path
from django.contrib.auth.decorators import login_required
from django.views.generic import TemplateView

from .views import EventListView
from .views import EventOlderListView
from .views import EventCreateView
from .views import EventDetailView
from .views import EventUpdateView
from .views import EventDeleteView

from .views import TeamCreateView
from .views import TeamUpdateView

from .views import CompetitionDetailView
from .views import RaceUpdateView
from .views import RaceCreateView

from .views import APIGpsCoordinatesView
from .views import APIGpsCoordinatesPointsView
from .views import APIResultTableEntry
from .views import ReplayData
from .views import ReplayView
# from .views import profile


app_name = 'events'


urlpatterns = [
    path('test/', APIGpsCoordinatesView.as_view(), name='test'),
    path('test2/', APIGpsCoordinatesPointsView.as_view(), name='test2'),
    path('test3/', APIResultTableEntry.as_view(), name='test3'),
    path('replay/data', ReplayData.as_view(), name='replay_data'),
    path('competitions/<int:competition>/replay/<int:pk>', ReplayView.as_view(), name='replay'),
    # path('competitions/<int:competition>/replay/<int:pk>', login_required(
    #     TemplateView.as_view(template_name='replay.html')), name='replay'),
    # path('test/',profile,name='test'),

    path('', EventListView.as_view(), name='list'),
    path('older', EventOlderListView.as_view(), name='older_list'),
    path('create/', EventCreateView.as_view(), name='create'),
    path('<int:pk>/', EventDetailView.as_view(), name='detail'),
    path('update/<int:pk>/', EventUpdateView.as_view(), name='update'),
    path('delete/<int:pk>/', EventDeleteView.as_view(), name='delete'),

    path('<int:event>/createteam/', TeamCreateView.as_view(), name='create_team'),
    path('<int:event>/updateteam/<int:pk>/', TeamUpdateView.as_view(), name='update_team'),

    path('competitions/<int:pk>/', CompetitionDetailView.as_view(), name='competition_detail'),
    path('competitions/<int:competition>/createrace', RaceCreateView.as_view(), name='create_race'),
    path('competitions/<int:competition>/updaterace/<int:pk>/',
         RaceUpdateView.as_view(), name='update_race'),

]
