-- ============================================
-- Cel transformacji:
-- 1. Pobranie danych z warstwy bronze (source).
-- 2. Usunięcie duplikatów wierszy na podstawie kolumn kluczowych.
-- 3. Dodanie surrogate_key jako hash kolumn kluczowych.
-- 4. Dodanie hashdiff dla kolumn biznesowych (detekcja zmian).
-- 5. Dodanie created_at z timestampem utworzenia rekordu.
-- ============================================

with
-- ============================================
-- wczytaj dane z warstwy bronze
-- ============================================
    bronze as (
        select *
        from {{ source('bronze', 'bronze_race_control') }}
    ),

-- ============================================
-- Deduplikacja rekordów
-- ============================================

    dedup as (
        select DISTINCT
            session_key,
            meeting_key,
            category,
            date,
            driver_number,
            flag,
            lap_number,
            message,
            scope,
            sector
        FROM bronze
    )

-- ============================================
-- Finalna tabela silver_drivers
-- ============================================

select
    *,
    
    -- surrogate_key: hash kolumn kluczowych
    md5(concat_ws('||', meeting_key, session_key, driver_number)) as id,
    
    -- hashdiff: hash kolumn biznesowych, wykrywanie zmian
    md5(concat_ws(
        '||',
        category,
        date,
        driver_number,
        flag,
        lap_number,
        message,
        scope,
        sector)
    ) as hashdiff,
    
    -- created_at: timestamp dodania rekordu
    current_timestamp() as created_at

from dedup



