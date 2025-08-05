-- Bronze: surowe dane sesji z Parquet w volume'u
SELECT *
FROM read_parquet('/shared_volume/bronze/sessions.parquet')