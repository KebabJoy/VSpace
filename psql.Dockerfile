FROM postgres:13

# Set environment variables
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD password
ENV POSTGRES_DB mydb

# Copy custom configuration file
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Start the PostgreSQL server
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
