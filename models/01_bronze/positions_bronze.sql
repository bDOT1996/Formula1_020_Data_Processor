-- Bronze: surowe dane pozycji
SELECT *
FROM read_parquet('/shared_volume/bronze/positions.parquet')