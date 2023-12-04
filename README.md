# Anthill Backend

A backend of Anthill charity accounting system.

## Configuration

### Environment

The following environment variables are required:

```
`NODE_ENV` - default: "development"
`http.`
    `host` - a http ip of the nest server to serve on. Mapped from HOST
    `port` - a port for the nest server to serve on. Mapped from PORT
    `staticPath` - a path to the built Anthill frontend directory. Mapped from STATIC_PATH
    
`database.`
    `host` - a http ip of the database server. Mapped from DB_HOST
    `port` - a port for the database server. Mapped from DB_PORT
    `username` - a database user name. Mapped from DB_USER
    `password` - a database user password. Mapped from DB_PASSWORD
    `database` - a database name to connect to. Mapped from DB
```

The variables must be set as environment variables or in a .env file.
For example, docker configuration for the default env would be:

```dockerfile
ENV NODE_ENV=production

ENV HOST=localhost
ENV PORT=5000
ENV STATIC_PATH=/anthill/frontend

ENV DB_HOST=localhost
ENV DB_PORT=5432
ENV DB_USER=anthill
ENV DB_PASSWORD=password
ENV DB=anthill
```

### Config

The system can be configured through changing values in the `config/common.yaml` file.
