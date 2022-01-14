#!/bin/sh

cd website || exit

python manage.py collectstatic --noinput
gunicorn --bind=0.0.0.0:8000 website.wsgi