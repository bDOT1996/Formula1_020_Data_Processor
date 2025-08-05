
# Instrukcja obsługi repozytorium DBT + DuckDB (abt_project)

---

## 📁 Struktura katalogów i rola elementów

- **seeds/**  
  Pliki CSV z lookupami lub wartościami referencyjnymi, np. `drivers_lookup.csv`.  
  Zawiera także `schema.yml` z testami (not_null, unique) i opisami kolumn.

- **models/**  
  - `bronze/` – ładowanie surowych danych z plików Parquet (np. przez `parquet_scan`).  
  - `silver/` – oczyszczanie i normalizacja danych (np. parsowanie dat, filtrowanie NULL).  
  - `gold/` – analityka i modele ABT (podsumowania, metryki).  
  Każdy model ma komentarze opisujące transformacje.

- **macros/**  
  Makra DBT, np. niestandardowe testy (`custom_tests.sql`) i funkcje pomocnicze (`utils.sql`).

- **tests/**  
  Dodatkowe testy SQL, niezależne od modeli DBT, np. do walidacji rozkładów danych.

- **Dockerfile**  
  Obraz Docker z DBT i DuckDB.

- **docker-compose.yml**  
  Orkiestracja kontenerów DBT i fetchera, z wolumenem współdzielonym.

- **seeds/schema.yml**  
  Definicja testów i opisów dla plików seed.

---

## 📦 Lokalizacja danych

- Surowe dane pobrane z API powinny być zapisywane do wolumenu `./data/bronze/*.parquet`.  
- Statyczne dane lookup trzymamy w `./seeds/*.csv`.  
- Wszystkie dane są lokalnie dostępne dla kontenerów poprzez zamontowany wolumen `./data`.

Przykładowe użycie w modelach DBT:
```sql
SELECT * FROM read_parquet('/data/bronze/sessions.parquet')
```

---

## 🚀 Jak uruchomić projekt

1. **Zbuduj i uruchom kontenery:**

```bash
docker-compose up --build
```

2. **Dostęp do kontenera DBT:**

```bash
docker exec -it abt_dbt /bin/bash
```

3. **W katalogu projektu wykonaj:**

- Pobierz zależności DBT (jeśli istnieją):

```bash
dbt deps --profiles-dir .
```

- Załaduj seedy (CSV):

```bash
dbt seed --profiles-dir .
```

- Uruchom pipeline:

```bash
dbt build --profiles-dir .
```

- Wygeneruj i podejrzyj dokumentację:

```bash
dbt docs generate && dbt docs serve
```

---

## 🧪 Testowanie danych i modeli

- Testy kolumn i tabel definiowane są w `schema.yml` i automatycznie uruchamiane podczas `dbt build`.  
- Niestandardowe testy znajdują się w `macros/custom_tests.sql`.  
- Dodatkowe testy SQL są w katalogu `tests/` i można je uruchamiać ręcznie lub zintegrować z DBT.

---

## ✅ Ważne wskazówki

- Upewnij się, że wolumen `./data` jest zamontowany do kontenerów i zawiera aktualne dane.  
- Modele DBT powinny używać `ref()` dla zależności między modelami (np. `{{ ref('clean_sessions') }}`).  
- Nie odwołuj się bezpośrednio do ścieżek plików w SQL poza ładowaniem surowych plików przez `read_parquet()`.  
- Zachowuj porządek warstw: bronze → silver → gold.

---

W razie pytań lub potrzeby rozbudowy projektu, śmiało pytaj!

---

*Plik wygenerowany na podstawie ustaleń projektu F1 DBT DuckDB.*