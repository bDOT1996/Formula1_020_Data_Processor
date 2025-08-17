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
        from {{ source('bronze', 'bronze_drivers') }}
    ),

-- ============================================
-- Deduplikacja rekordów
-- ============================================

    dedup as (
        select DISTINCT
            meeting_key,
            session_key,
            driver_number,
            team_name,
            broadcast_name,
            name_acronym,
            country_code,
            team_colour,
            first_name,
            full_name,
            last_name,
            headshot_url
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
        team_name,
        broadcast_name,
        name_acronym,
        country_code,
        team_colour,
        first_name,
        full_name,
        last_name,
        headshot_url)
    ) as hashdiff,
    
    -- created_at: timestamp dodania rekordu
    current_timestamp() as created_at

from dedup



