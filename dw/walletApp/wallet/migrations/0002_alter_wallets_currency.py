# Generated by Django 3.2.9 on 2023-01-11 14:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wallet', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='wallets',
            name='currency',
            field=models.CharField(max_length=1024),
        ),
    ]