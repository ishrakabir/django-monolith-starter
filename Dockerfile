FROM python:3.9-alpine3.13
LABEL maintainer="Ishrak"

ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000 

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user

# এই Dockerfile যা করছে:

# Python base image নিচ্ছে

# Django project কপি করছে

# Virtualenv বানাচ্ছে

# Dependency install করছে

# Root ছাড়া user দিয়ে app চালানোর environment বানাচ্ছে