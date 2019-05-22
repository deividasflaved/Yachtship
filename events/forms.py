"""
Place your forms here
"""

from django import forms

from django.contrib.auth.models import User, Group
from django.db.models import Q

from .models import Competition
from .models import Race
from .models import Team
from .models import GpsCoordinates
from .models import ResultTable


class CompetitionForm(forms.ModelForm):
    """
    Custom form for competitions
    """

    class Meta:
        model = Competition
        fields = ('title', 'start_date', 'referee')
        widgets = {
            'title': forms.TextInput(attrs={'class': "form-control shadow-lg"}),
            'start_date': forms.DateInput(attrs={'class': "form-control shadow-lg"})
        }

    referee = forms.ModelMultipleChoiceField(
        queryset=User.objects.filter(Q(groups__name="Basic") | Q(groups__name="Referee")))

    def __init__(self, *args, **kwargs):
        if kwargs.get('instance'):
            initial = kwargs.setdefault('initial', {})
            initial['referee'] = [t.pk for t in kwargs['instance'].referee.all()]

        forms.ModelForm.__init__(self, *args, **kwargs)

    # Overriding save method to save M2M field
    def save(self, commit=True):
        instance = forms.ModelForm.save(self, False)

        # Prepare a 'save_m2m' method for the form,
        old_save_m2m = self.save_m2m

        def save_m2m():
            old_save_m2m()
            old_referees = list(instance.referee.all())
            instance.referee.clear()
            instance.referee.add(*self.cleaned_data['referee'])
            group_basic = Group.objects.get(name='Basic')
            group_referee = Group.objects.get(name='Referee')

            for referee in self.cleaned_data['referee']:
                user = User.objects.filter(username=referee)[0]
                if user.groups.all()[0].name == 'Basic':
                    group_basic.user_set.remove(user)
                    group_referee.user_set.add(user)

            for referee in old_referees:
                user = User.objects.filter(username=referee)[0]
                if len(user.user_referee.all()) < 1:
                    if referee not in instance.referee.all():
                        group_basic.user_set.add(user)
                        group_referee.user_set.remove(user)

        self.save_m2m = save_m2m  # pylint: disable=attribute-defined-outside-init

        # Do we need to save all changes now?
        if commit:
            instance.save()
            self.save_m2m()

        return instance


class RaceForm(forms.ModelForm):
    """
    Custom form for races
    """

    class Meta:
        model = Race
        fields = ('title', 'start_date')
        widgets = {
            'title': forms.TextInput(attrs={'class': "form-control shadow-lg", 'placeholder': 'R1'})
        }
    start_date = forms.SplitDateTimeField(widget=forms.SplitDateTimeWidget(
                date_attrs={'class': "form-control form-control-split shadow-lg", 'placeholder': '2019-05-09'},
                time_attrs={'class': "form-control form-control-split shadow-lg", 'placeholder': '13:29:49'}))


class RaceFormAPI(forms.ModelForm):
    """
    Custom form for race API
    """

    class Meta:
        model = Race
        fields = ('start_coordinates', 'finish_coordinates',
                  'referee_coordinates', 'checkpoint_coordinates')

    def __init__(self, *args, **kwargs):
        super(RaceFormAPI, self).__init__(*args, **kwargs)
        contains = False
        for field in self.Meta.fields:
            for arg in args[0]:
                if field in arg:
                    contains = True
            if not contains:
                self.fields.pop(field)
            contains = False


class ResultTableEntry(forms.ModelForm):
    """
    Custom form for result table
    """

    class Meta:
        model = ResultTable
        exclude = ()  # pylint: disable=modelform-uses-exclude


class TestForm(forms.ModelForm):
    """
    Custom form for gps coordinates for user
    """

    class Meta:
        model = GpsCoordinates
        exclude = ('team', 'time',)  # pylint: disable=modelform-uses-exclude


class TeamForm(forms.ModelForm):
    """
    Custom form for team registration
    """

    class Meta:
        model = Team
        exclude = ('event', 'user',)  # pylint: disable=modelform-uses-exclude
        labels = {
            'captain_name': 'Team leader name',
            'image': 'Team logo/Yacht picture',
        }
        widgets = {
            'team_name': forms.TextInput(attrs={'class': "form-control shadow-lg"}),
            'captain_name': forms.TextInput(attrs={'class': "form-control shadow-lg"}),
            'team_members': forms.TextInput(attrs={'class': "form-control shadow-lg"}),
            'image': forms.FileInput(attrs={'class': "custom-file"})
        }
