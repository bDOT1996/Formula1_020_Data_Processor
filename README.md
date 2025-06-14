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