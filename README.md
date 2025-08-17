# Struktura repozytorium DBT + Snowflake
```
.
├── dbt_project.yml
├── docker-compose.yml
├── Dockerfile
├── macros
│   └── utils.sql
├── models
│   ├── 01_bronze                  
│   │   └── schema.yml
│   ├── 02_silver
│   │   ├── schema.yml
│   │   ├── silver_drivers.sql
│   │   ├── silver_meetings.sql
│   │   ├── silver_race_control.sql 
│   │   └── silver_sessions.sql     
│   └── 03_gold
│       ├── gold_meetings.sql    
│       └── schema.yml
├── packages.yaml
├── profiles.yml
├── README_instruction.md
├── README.md
├── seeds
└── tests
```


## Overview
Repo zawiera konfigurację i skrypty DbT przetwarzające dane w Snowflaku pochodzące z [OpenF1](https://openf1.org/#race-control). Wszystko jest kontenerowane. Docelowo kontener ma być orkiestrowany przez Airflow i ma być częścią aplikacji.

**Bronze** Jest napełniany danymi z innej części projektu: [Data_Fetcher](https://github.com/bDOT1996/Formula1_010_Data_Fetcher).
**Silver** Jest w trakcie zapisywania - ma obejmować deduplikację danych (api niestety ma bugi i zwraca czasami duplikaty).
**Gold** Czeka na swoją kolej.
**Raports** Czeka na swoją kolej.

**testy** W trakcie przygotowania.
**macros** W trakcie przygotowania.
**snapshots** W trakcie przygotowania.



## Installation
1. Sklonuj repo
   ```bash
   git clone https://github.com/bDOT1996/Formula1_020_Data_Processor.git
   cd  Formula1_020_Data_Processor
   ```
2. stwórz i wypełnij swoim poświadczeniami .env:
   ```plaintext
   SF_ACCOUNT=your_snowflake_ACCOUNT
   SF_USER=your_snowflake_USER
   SF_PASSWORD=your_snowflake_PASSWORD
   SF_DATABASE=your_snowflake_DATABASE
   SF_SCHEMA=your_snowflake_SCHEMA
   SF_WAREHOUSE=your_snowflake_WAREHOUSE
   ```
3. zbuduj i uruchom Dockera:
   ```bash
   docker compose up --build
   ```

