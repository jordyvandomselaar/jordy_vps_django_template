FROM python:3-alpine

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN mkdir /app
WORKDIR /app
COPY . /app


RUN addgroup -S app \
    && adduser -S app -G app\
    && apk update \
    && apk add --no-cache postgresql-dev gcc python3-dev musl-dev\
    && pip install --no-cache-dir -r requirements.txt \
    && chown -R app:app /app/static \
    && chown -R app:app /app

USER app