FROM python:3.13

RUN pip install dbt-core dbt-duckdb flask

WORKDIR /app

COPY . .

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]