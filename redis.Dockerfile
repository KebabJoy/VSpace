FROM redis:6.2.5-alpine

# Expose the Redis port
EXPOSE 6379

# Start the Redis server
CMD ["redis-server"]
