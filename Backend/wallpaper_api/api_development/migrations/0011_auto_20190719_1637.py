# Generated by Django 2.2.3 on 2019-07-19 11:07

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api_development', '0010_auto_20190719_1635'),
    ]

    operations = [
        migrations.AlterField(
            model_name='api',
            name='link',
            field=models.CharField(blank=True, max_length=500, null=True),
        ),
    ]
