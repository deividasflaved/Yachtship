from django.contrib import admin
from django.contrib.admin import register

from events.models import Event
from events.models import Competition
from events.models import Race




class CompetitionAdminInline(admin.StackedInline):
    model = Competition
    extra = 1

class RaceAdminInline(admin.StackedInline):
    model = Race
    extra = 1



@register(Event)
class EventAdmin(admin.ModelAdmin):
    inlines = [CompetitionAdminInline]
    list_display = ('id', 'title')

@register(Competition)
class CompetitionAdmin(admin.ModelAdmin):
    inlines = [RaceAdminInline]
    list_display = ('id', 'title')