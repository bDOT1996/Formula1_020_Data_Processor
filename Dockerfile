# Etap 1: Instalacja systemowych zależności
FROM ubuntu:20.04 AS base

RUN apt-get update && \
    apt-get install -y \
    curl \
    python3-venv \
    python3.12 \
    sudo \
    vim \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Ustawienie domyślnego Pythona na 3.12
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1

# Instalacja Poetry
RUN curl -SSL https://install.python-poetry.org | python3 -

# Etap 2: Konfiguracja środowiska
FROM base AS dev

WORKDIR /workspace

COPY pyproject.toml .
RUN poetry install --no-dev

COPY . .

# Etap 3: Instalacja Airflow
FROM apache/airflow:2.9.3-python3.12 AS airflow

USER root

COPY --from=dev /workspace /workspace
WORKDIR /workspace

RUN pip install --no-cache-dir -r airflow/requirements.txt
