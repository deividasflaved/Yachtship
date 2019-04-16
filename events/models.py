# Required for generating thumbnail
import os.path
from datetime import datetime  
from datetime import date
from django.core.files.base import ContentFile
from io import BytesIO
from PIL import Image
from django.conf import settings
from django import forms

from django.db import models
from django.forms import ModelForm





THUMB_SIZE = (256, 256)


class Event(models.Model):
    title = models.CharField(max_length=80, blank=False, null=False)
    description = models.TextField(blank=True, null=True)
    event_date = models.DateField(null=False, blank=False, default=date.today)
    created_at = models.DateTimeField(auto_now_add=True, blank=True)
    edited_at = models.DateTimeField(auto_now=True, blank=True)
    image = models.ImageField(upload_to='user/images', blank=True, null=True)
    thumbnail = models.ImageField(upload_to='user/images/thumbnails', editable=False)


    def save(self, *args, **kwargs):
        if not self.make_thumbnail():
            # TODO: Set to a default thumbnail
            # raise Exception('Could not create thumbnail. File type not supported.')
            pass

        super().save(*args, **kwargs)


    def make_thumbnail(self):
        if self.image:
            image = Image.open(self.image)
            image.thumbnail(THUMB_SIZE, Image.ANTIALIAS)

            thumb_name, thumb_extension = os.path.splitext(self.image.name)
            thumb_extension = thumb_extension.lower()

            thumb_filename = thumb_name + '_thumb' + thumb_extension

            if thumb_extension in ['.jpg', '.jpeg']:
                FTYPE = 'JPEG'
            elif thumb_extension == '.gif':
                FTYPE = 'GIF'
            elif thumb_extension == '.png':
                FTYPE = 'PNG'
            else:
                # Unrecognized file type
                return False

            # Save thumbnail to in-memory file as StringIO
            temp_thumb = BytesIO()
            image.save(temp_thumb, FTYPE)
            temp_thumb.seek(0)

            # set save=False, otherwise it will run in an infinite loop
            self.thumbnail.save(thumb_filename, ContentFile(temp_thumb.read()), save=False)
            temp_thumb.close()

            return True
        
        return False

class Competition(models.Model):
    title = models.CharField(max_length=80, blank=False, null=False)
    start_date = models.DateField(null=False, blank=False, default=date.today)
    event = models.ForeignKey(Event, related_name='competitions', on_delete=models.CASCADE)
    referee = models.ManyToManyField(settings.AUTH_USER_MODEL, blank=True, related_name='user_referee')
    
    class Meta:
        db_table = 'events_competition'

    def __str__(self):
        return self.title

    

class Team(models.Model):
    team_name = models.CharField(max_length=80, blank=False, null=False)
    captain_name = models.CharField(max_length=80, blank=False, null=False)
    team_members = models.CharField(max_length=255, blank=False, null=False)
    image = models.ImageField(upload_to='user/images', blank=True, null=True)
    thumbnail = models.ImageField(upload_to='user/images/thumbnails', editable=False)
    event = models.ForeignKey(Event, related_name='teams', on_delete=models.CASCADE)
    user = models.ForeignKey(settings.AUTH_USER_MODEL,related_name='user_teams', on_delete=models.CASCADE)

    def save(self, *args, **kwargs):
        if not self.make_thumbnail():
            # TODO: Set to a default thumbnail
            # raise Exception('Could not create thumbnail. File type not supported.')
            pass

        super().save(*args, **kwargs)


    def make_thumbnail(self):
        if self.image:
            image = Image.open(self.image)
            image.thumbnail(THUMB_SIZE, Image.ANTIALIAS)

            thumb_name, thumb_extension = os.path.splitext(self.image.name)
            thumb_extension = thumb_extension.lower()

            thumb_filename = thumb_name + '_thumb' + thumb_extension

            if thumb_extension in ['.jpg', '.jpeg']:
                FTYPE = 'JPEG'
            elif thumb_extension == '.gif':
                FTYPE = 'GIF'
            elif thumb_extension == '.png':
                FTYPE = 'PNG'
            else:
                # Unrecognized file type
                return False

            # Save thumbnail to in-memory file as StringIO
            temp_thumb = BytesIO()
            image.save(temp_thumb, FTYPE)
            temp_thumb.seek(0)

            # set save=False, otherwise it will run in an infinite loop
            self.thumbnail.save(thumb_filename, ContentFile(temp_thumb.read()), save=False)
            temp_thumb.close()

            return True
        
        return False

class Race(models.Model):
    title = models.CharField(max_length=80, blank=False, null=False)
    duration = models.DurationField(blank=False, null=True)
    winner = models.CharField(max_length=80, blank=False, null=True)
    start_coordinates = models.CharField(max_length=80, blank=False, null=True)
    finish_coordinates = models.CharField(max_length=80, blank=False, null=True)
    start_date = models.DateField(blank=False, null=True)
    competition = models.ForeignKey(Competition, related_name='races',on_delete=models.CASCADE)

class GpsCoordinates(models.Model):
    latitude = models.CharField(max_length=80, blank=False, null=False)
    longitude = models.CharField(max_length=80, blank=False, null=False)
    time = models.DateTimeField(default=datetime.now(), blank=False, null=False)
    team = models.ForeignKey(Team, related_name='team', on_delete=models.CASCADE)