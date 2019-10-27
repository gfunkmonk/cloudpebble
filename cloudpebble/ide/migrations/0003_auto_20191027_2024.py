# -*- coding: utf-8 -*-
# Generated by Django 1.9.12 on 2019-10-27 20:24
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ide', '0002_auto_20191026_0611'),
    ]

    operations = [
        migrations.AlterField(
            model_name='usersettings',
            name='keybinds',
            field=models.CharField(choices=[(b'default', 'Standard'), (b'vim', 'vim-like'), (b'emacs', 'emacs-like'), (b'sublime', 'sublime-like')], default=b'default', max_length=20, verbose_name='Keybinds'),
        ),
    ]
