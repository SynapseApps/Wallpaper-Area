# Generated by Django 2.2.3 on 2019-07-10 12:55

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api_development', '0002_auto_20190708_2213'),
    ]

    operations = [
        migrations.AddField(
            model_name='category',
            name='cover_page',
            field=models.CharField(max_length=150, null=True),
        ),
    ]
