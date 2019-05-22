"""
Place your admin functions here
"""

from django.contrib import admin
from django.contrib.admin import register

from events.models import Event, Team, GpsCoordinates
from events.models import Competition
from events.models import Race


class CompetitionAdminInline(admin.StackedInline):
    """
    Admin competition editing
    """
    model = Competition
    extra = 1


class RaceAdminInline(admin.StackedInline):
    """
    Admin race editing
    """
    model = Race
    extra = 1


@register(Event)
class EventAdmin(admin.ModelAdmin):
    """
    Admin event editing
    """
    inlines = [CompetitionAdminInline]
    list_display = ('id', 'title')


@register(Competition)
class CompetitionAdmin(admin.ModelAdmin):
    """
    Admin competition editing
    """
    inlines = [RaceAdminInline]
    list_display = ('id', 'title')


@register(Team)
class TeamAdmin(admin.ModelAdmin):
    """
    Admin competition editing
    """
    list_display = ('id', 'team_name')


@register(GpsCoordinates)
class GpsCoordinatesAdmin(admin.ModelAdmin):
    """
    Admin competition editing
    """
    list_display = ('id', 'latitude', 'longitude', 'time', 'team')