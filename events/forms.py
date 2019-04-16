from django import forms
from django.forms.models import inlineformset_factory

from django.conf import settings
from django.contrib.auth.models import User

from .models import Competition
from .models import Event
from .models import Race
from .models import Team
from .models import GpsCoordinates


class CompetitionForm(forms.ModelForm):
    class Meta:
        model = Competition
        fields = ('title',  'start_date', 'referee')
    referee = forms.ModelMultipleChoiceField(queryset=User.objects.all())

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
           instance.referee.clear()
           instance.referee.add(*self.cleaned_data['referee'])
        self.save_m2m = save_m2m

        # Do we need to save all changes now?
        if commit:
            instance.save()
            self.save_m2m()

        return instance




class RaceForm(forms.ModelForm):

    class Meta:
        model = Race
        exclude = ('duration', 'winner','competition')
        widgets = { 
            'start_date': forms.SelectDateWidget(), 
            }


class TestForm(forms.ModelForm):
    class Meta:
        model = GpsCoordinates
        exclude = ('team','time',)
        



class TeamForm(forms.ModelForm):

    class Meta:
        model = Team
        exclude = ('event','user',)
        labels = {
            'captain_name': 'Team leader name',
            'image': 'Team logo/Yacht picture',
        }
    


