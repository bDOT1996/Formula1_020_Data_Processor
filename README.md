# Struktura repozytorium DBT + DuckDB (abt_project)
```
abt_project/
├── dbt_project.yml            # Główny plik konfiguracyjny DBT
├── profiles.yml               # Profile połączenia z DuckDB
├── packages.yml               # Zewnętrzne pakiety DBT (np. dbt-utils)
├── seeds/                     # Pliki CSV ładowane jako tabele seed
│   ├── drivers_lookup.csv     # Przykładowa tabela lookup kierowców
│   └── schema.yml             # Testy i opis seedów
├── macros/                    # Makra DBT (custom tests, helper macros)
│   ├── custom_tests.sql       # Niestandardowe testy SQL
│   └── utils.sql              # Makra pomocnicze (safe_divide, etc.)
├── tests/                     # Ad-hoc testy SQL
│   ├── test_driver_id_positive.sql
│   └── test_avg_lap_time_range.sql
├── models/                    # Katalog z modelami SQL
│   ├── bronze/                # Warstwa Bronze (surowe dane)
│   │   ├── sessions_bronze.sql
│   │   ├── drivers_bronze.sql
│   │   └── positions_bronze.sql
│   ├── silver/                # Warstwa Silver (czyszczenie)
│   │   ├── clean_sessions.sql
│   │   ├── clean_drivers.sql
│   │   ├── clean_positions.sql
│   │   └── clean_laptimes.sql
│   └── gold/                  # Warstwa Gold (analityka)
│       ├── driver_position_counts.sql
│       └── driver_avg_laptime_vs_position.sql
├── Dockerfile                 # Budowanie obrazu DBT + DuckDB
├── docker-compose.yml         # Orkiestracja serwisów fetcher + dbt + airflow
├── .gitignore                 # Ignorowanie plików tymczasowych
└── README.md                  # Instrukcja obsługi repozytorium
```

1. **Seed:** dodaj/edytuj CSV w `seeds/`, uruchom `dbt seed`.
2. **Modele:** dodaj SQL w odpowiedniej warstwie (`bronze/silver/gold`).
3. **Makra/Testy:** makra do `macros/`, testy w `schema.yml` lub `tests/`.
4. **Uruchamianie:** `dbt build --profiles-dir .`
5. **Dokumentacja:** `dbt docs generate && dbt docs serve`



## README.md
```markdown
# ABT Project (DBT + DuckDB)

Projekt wykonuje transformacje danych F1 w trzech warstwach:
- Bronze: surowe Parquet
- Silver: oczyszczone dane
- Gold: analizy i agregacje

## Uruchomienie lokalne
1. Utwórz shared_volume:
   ```bash
docker volume create shared_volume
```
2. Uruchom fetchera i DBT:
   ```bash
docker-compose up --build f1-data-fetcher dbt
```
3. Uruchom komendy DBT w kontenerze:
   ```bash
# w kontenerze dbt
cd /app
dbt deps
dbt run
dbt test
```

## CI/CD (GitHub Actions)
Konfiguracja w `.github/workflows/dbt-ci.yml`.

## Debug i dokumentacja
```bash
dbt docs generate
dbt docs serve
```
```

---

## Instrukcja obsługi repo

1. **Seed:** dodaj/edytuj CSV w `seeds/`, uruchom `dbt seed`.
2. **Modele:** dodaj SQL w odpowiedniej warstwie (`bronze/silver/gold`).
3. **Makra/Testy:** makra do `macros/`, testy w `schema.yml` lub `tests/`.
4. **Uruchamianie:** `dbt build --profiles-dir .`
5. **Dokumentacja:** `dbt docs generate && dbt docs serve`


# Formula1 Data Processor

To repozytorium zawiera projekt DBT do przetwarzania danych Formula1 przez warstwy brązową, srebrną i złotą przy użyciu DuckDB.

## Rozwój

1. Otwórz repozytorium w VS Code z rozszerzeniem Remote - Containers.
2. Kontener zostanie automatycznie zbudowany i uruchomiony.
3. Uruchamiaj polecenia DBT z terminala, np. `dbt run`.

## Budowanie obrazu produkcyjnego

1. `docker build -t formula1-data-processor .`

## Uruchamianie z Docker Compose

1. Upewnij się, że masz plik `docker-compose.yml` w tym repozytorium.
2. Uruchom usługę: `docker compose up -d`
3. Usługa wykona domyślne polecenie `dbt run` zdefiniowane w Dockerfile, a następnie uruchomi serwer Flask.

## Dostęp przez localhost

- Kontener udostępnia bazę danych DuckDB przez serwer Flask na porcie 8002 hosta.
- Możesz wysyłać zapytania SQL pod adresem: `http://localhost:8002/query?sql=SELECT * FROM table_name`.
- Przykład zapytania: `http://localhost:8002/query?sql=SELECT * FROM races`.

## Zatrzymywanie usługi

1. `docker compose down`

## Pushowanie zmian

1. Wewnątrz kontenera użyj poleceń git: `git add .`, `git commit -m "wiadomość"`, `git push`.
2. Upewnij się, że poświadczenia git są skonfigurowane.

## Przyszła orkiestracja z Kubernetes

Ta usługa jest zaprojektowana do orkiestracji w Kubernetes. Obrazy Docker zbudowane tutaj mogą być pushowane do rejestru kontenerów (np. Docker Hub) i używane w deploymentach Kubernetes. Więcej informacji znajdziesz w [dokumentacji Kubernetes](https://kubernetes.io/docs/home/).