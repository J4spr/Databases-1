FROM postgres:18

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=Student_1234

# Copy initialization script directly into the entrypoint folder
COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432