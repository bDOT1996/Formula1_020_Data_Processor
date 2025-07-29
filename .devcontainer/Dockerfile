# ---- BAZA ----
FROM python:3.11-slim

# ---- SYSTEM ----
RUN apt-get update && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

# ---- PYTHON PACKAGES ----
RUN pip install --no-cache-dir duckdb dbt-core dbt-duckdb

# ---- DuckDB EXTENSIONS ----
RUN duckdb -c "INSTALL delta; INSTALL azure; LOAD delta; LOAD azure;"

# ---- WORKDIR ----
WORKDIR /workspace

# ---- KOPIUJ PLIK PROJEKTU ----
COPY . /workspace
