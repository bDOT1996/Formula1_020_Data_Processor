FROM python:3.11-slim

# Instalacja zależności systemowych
RUN apt-get update && apt-get install -y git curl

# Instalacja DBT i adaptera Snowflake
RUN pip install --no-cache-dir dbt-snowflake

# Ustaw katalog roboczy
WORKDIR /usr/app

# Kopiowanie repozytorium DBT
COPY . .

# Domyślna komenda
CMD ["dbt", "run"]
