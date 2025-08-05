# Użyj lekkiego obrazu z Pythonem
FROM python:3.11-slim

# Ustaw katalog roboczy
WORKDIR /app

# Zainstaluj zależności systemowe potrzebne dla DuckDB
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Zainstaluj DBT z DuckDB i inne przydatne dodatki
RUN pip install --upgrade pip && \
    pip install dbt-duckdb dbt-utils pandas

# Skopiuj pliki projektu do obrazu
COPY . /app

# Domyślny katalog przy uruchomieniu kontenera
CMD ["dbt", "run"]
