"""
Create your models here
"""
# Required for generating thumbnail
import os.path
from datetime import datetime
from datetime import date
from io import BytesIO
from PIL import Image
from django.core.files.base import ContentFile
from django.conf import settings

from django.db import models

THUMB_SIZE = (256, 256)


class Event(models.Model):
    """
    Model for events
    """
    title = models.CharField(max_length=80, blank=False, null=False)
    description = models.TextField(blank=True, null=True)
    event_date = models.DateField(null=False, blank=False, default=date.today)
    created_at = models.DateTimeField(auto_now_add=True, blank=True)
    edited_at = models.DateTimeField(auto_now=True, blank=True)
    image = models.ImageField(upload_to='user/images', blank=True, null=True)
    thumbnail = models.ImageField(upload_to='user/images/thumbnails', editable=False)

    def save(self, *args, **kwargs):  # pylint: disable=arguments-differ
        if not self.make_thumbnail():
            # raise Exception('Could not create thumbnail. File type not supported.')
            pass

        super().save(*args, **kwargs)

    def make_thumbnail(self):
        """
        Creates thumbnail
        """
        if self.image:
            image = Image.open(self.image)
            image.thumbnail(THUMB_SIZE, Image.ANTIALIAS)

            thumb_name, thumb_extension = os.path.splitext(self.image.name)
            thumb_extension = thumb_extension.lower()

            thumb_filename = thumb_name + '_thumb' + thumb_extension

            if thumb_extension in ['.jpg', '.jpeg']:
                ftype = 'JPEG'
            elif thumb_extension == '.gif':
                ftype = 'GIF'
            elif thumb_extension == '.png':
                ftype = 'PNG'
            else:
                # Unrecognized file type
                return False

            # Save thumbnail to in-memory file as StringIO
            temp_thumb = BytesIO()
            image.save(temp_thumb, ftype)
            temp_thumb.seek(0)

            # set save=False, otherwise it will run in an infinite loop
            self.thumbnail.save(thumb_filename, ContentFile(temp_thumb.read()), save=False)
            temp_thumb.close()

            return True

        return False

    def __str__(self):
        return self.title


class Competition(models.Model):
    """
    Model for competitions
    """
    title = models.CharField(max_length=80, blank=False, null=False)
    start_date = models.DateField(null=False, blank=False, default=date.today)
    event = models.ForeignKey(Event, related_name='competitions', on_delete=models.CASCADE)
    referee = models.ManyToManyField(
        settings.AUTH_USER_MODEL, blank=True, related_name='user_referee')

    class Meta:
        db_table = 'events_competition'

    def __str__(self):
        return self.title


class Team(models.Model):
    """
    Model for teams
    """
    team_name = models.CharField(max_length=80, blank=False, null=False)
    captain_name = models.CharField(max_length=80, blank=False, null=False)
    team_members = models.CharField(max_length=255, blank=False, null=False)
    image = models.ImageField(upload_to='user/images', blank=True, null=True)
    thumbnail = models.ImageField(upload_to='user/images/thumbnails', editable=False)
    event = models.ForeignKey(Event, related_name='teams', on_delete=models.CASCADE)
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, related_name='user_teams', on_delete=models.CASCADE)

    def save(self, *args, **kwargs):  # pylint: disable=arguments-differ
        if not self.make_thumbnail():
            # raise Exception('Could not create thumbnail. File type not supported.')
            pass

        super().save(*args, **kwargs)

    def make_thumbnail(self):
        """
        Creates thumbnail
        """
        if self.image:
            image = Image.open(self.image)
            image.thumbnail(THUMB_SIZE, Image.ANTIALIAS)

            thumb_name, thumb_extension = os.path.splitext(self.image.name)
            thumb_extension = thumb_extension.lower()

            thumb_filename = thumb_name + '_thumb' + thumb_extension

            if thumb_extension in ['.jpg', '.jpeg']:
                ftype = 'JPEG'
            elif thumb_extension == '.gif':
                ftype = 'GIF'
            elif thumb_extension == '.png':
                ftype = 'PNG'
            else:
                # Unrecognized file type
                return False

            # Save thumbnail to in-memory file as StringIO
            temp_thumb = BytesIO()
            image.save(temp_thumb, ftype)
            temp_thumb.seek(0)

            # set save=False, otherwise it will run in an infinite loop
            self.thumbnail.save(thumb_filename, ContentFile(temp_thumb.read()), save=False)
            temp_thumb.close()

            return True

        return False

    def __str__(self):
        return self.team_name


class Race(models.Model):
    """
    Model for races
    """
    title = models.CharField(max_length=80, blank=False, null=False)
    duration = models.DurationField(blank=False, null=True)
    winner = models.CharField(max_length=80, blank=False, null=True)
    start_coordinates = models.CharField(max_length=80, blank=True, null=True)
    checkpoint_coordinates = models.CharField(max_length=80, blank=True, null=True)
    referee_coordinates = models.CharField(max_length=80, blank=True, null=True)
    finish_coordinates = models.CharField(max_length=80, blank=True, null=True)
    start_date = models.DateTimeField(blank=False, null=True)
    competition = models.ForeignKey(
        Competition, related_name='races', on_delete=models.CASCADE)

    def __str__(self):
        return self.title


class ResultTable(models.Model):
    """
    Model for race result table entry
    """
    time = models.TimeField(blank=False, null=False)
    team = models.ForeignKey(Team, related_name='team_result', on_delete=models.CASCADE)
    race = models.ForeignKey(Race, related_name='race', on_delete=models.CASCADE)


class GpsCoordinates(models.Model):
    """
    Model to save user gps coordinates
    """
    latitude = models.CharField(max_length=80, blank=False, null=False)
    longitude = models.CharField(max_length=80, blank=False, null=False)
    time = models.DateTimeField(default=datetime.now(), blank=False, null=False)
    team = models.ForeignKey(Team, related_name='team', on_delete=models.CASCADE)
