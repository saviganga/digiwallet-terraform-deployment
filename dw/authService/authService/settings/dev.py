from .base import *
import os
import sys


DEBUG = True  # to be changed back
SECRET_KEY = os.environ.get('SECRET_KEY')

ALLOWED_HOSTS = ["*"]


if "test" in sys.argv:
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.sqlite3",
            "NAME": ":memory:",
        }
    }
else:
    DATABASES = {

        "default": {        
            "ENGINE": "django.db.backends.postgresql",
            "NAME": os.environ.get('POSTGRES_DB'),
            "USER": os.environ.get('POSTGRES_USER'),
            "PASSWORD": os.environ.get('POSTGRES_PASSWORD'),
            "HOST": os.environ.get('POSTGRES_HOST'),
            "PORT": 5432,
        },

        "config": {        
            "ENGINE": "django.db.backends.postgresql",
            "NAME": os.environ.get('POSTGRES_DB'),
            "USER": os.environ.get('POSTGRES_USER'),
            "PASSWORD": os.environ.get('POSTGRES_PASSWORD'),
            "HOST": os.environ.get('POSTGRES_HOST'),
            "PORT": 5432,
        },

    }

CELERY_BROKER_URL = "redis://redis:6379/0"
CELERY_RESULT_BACKEND = "redis://redis:6379/0"
REDIS_URL = "redis://redis:6379/0"

JWT_SECRET_KEY = os.environ.get('JWT_SECRET_KEY')