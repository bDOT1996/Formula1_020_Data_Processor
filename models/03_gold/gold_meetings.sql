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
    silver as (
        select *
        from {{ ref('silver_meetings') }}
    )

-- ============================================
-- Finalna tabela
-- ============================================

select
    *

from silver



