# Generated by Django 2.1.7 on 2019-03-17 09:43

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('events', '0002_event_price'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='event',
            name='price',
        ),
        migrations.AddField(
            model_name='event',
            name='date',
            field=models.DateField(default=datetime.date.today),
        ),
    ]