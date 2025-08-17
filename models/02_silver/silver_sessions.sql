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
        from {{ source('bronze', 'bronze_sessions') }}
    ),

-- ============================================
-- Deduplikacja rekordów
-- ============================================

    dedup as (
        select DISTINCT
            year,
            meeting_key,
            session_key,
            circuit_key,
            circuit_short_name,
            country_code,
            country_key,
            country_name,
            date_end,
            date_start,
            gmt_offset,
            location,
            session_name,
            session_type
        FROM bronze
    )

-- ============================================
-- Finalna tabela
-- ============================================

select
    *,
    
    -- surrogate_key: hash kolumn kluczowych
    md5(concat_ws('||', year, meeting_key, session_key)) as id,
    
    -- hashdiff: hash kolumn biznesowych, wykrywanie zmian
    md5(concat_ws(
            '||', 
            year,
            meeting_key,
            session_key,
            circuit_key,
            circuit_short_name,
            country_code,
            country_key,
            country_name,
            date_end,
            date_start,
            gmt_offset,
            location,
            session_name,
            session_type)
       ) as hashdiff,
    
    -- created_at: timestamp dodania rekordu
    current_timestamp() as created_at

from dedup



