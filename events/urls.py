from django.urls import path
from django.conf.urls import include, url

from .views import EventListView
from .views import EventOlderListView
from .views import EventCreateView
from .views import EventDetailView
from .views import EventUpdateView
from .views import EventDeleteView

from .views import TeamCreateView
from .views import TeamUpdateView

from .views import CompetitionDetailView
from .views import CompetitionsUpdateView
from .views import RaceUpdateView
from .views import RaceCreateView

from .views import CoordinatesCreateView

from .views import GpsCoordinatesView
# from .views import profile


app_name = 'events'


urlpatterns = [
    path('test/',GpsCoordinatesView.as_view(),name='test'),
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
    path('competitions/<int:competition>/updaterace/<int:pk>/', RaceUpdateView.as_view(), name='update_race'),

]
