FROM python:3-alpine

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY . /app


RUN addgroup -S app \
    && adduser -S app -G app\
    && apk update \
    && apk add --no-cache postgresql-dev gcc python3-dev musl-dev\
    && pip install --no-cache-dir -r requirements.txt \
    && chown -R app:app /app \
    && chown -R app:app /app/data

USER app