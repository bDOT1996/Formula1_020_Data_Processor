FROM python:3.11-slim

# 1. Zaktualizuj pakiety i zainstaluj DuckDB
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && pip install --no-cache-dir duckdb duckdb-engine

# 2. Zainstaluj dbt-core, dbt-duckdb, adlfs (ADLS connector) i inne zależności
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# 3. Utwórz katalog roboczy
WORKDIR /workspace

# 4. (opcjonalnie) skopiuj profile dbt, jeżeli masz w repo
# COPY .dbt /workspace/.dbt

CMD ["bash"]
