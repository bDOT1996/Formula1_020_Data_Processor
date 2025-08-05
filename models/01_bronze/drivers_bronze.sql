-- Bronze: surowe dane kierowców
SELECT *
FROM read_parquet('/shared_volume/bronze/drivers.parquet')