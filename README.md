# Anthill Backend

A backend of Anthill charity accounting system.

## Configuration

### Environment

The following environment variables are used:

General:

```
`NODE_ENV` - Default: "development"
```

HTTP:

```
`HOST` - a http ip of the nest server to serve on.
`PORT` - a port for the nest server to serve on.
`STATIC_PATH` - a path to the built Anthill frontend directory.
```

Database:

```
`DB_HOST`     - a http ip of the database server.
`DB_PORT`     - a port for the database server.
`DB_USER`     - a database user name.
`DB_PASSWORD` - a database user password.
`DB`          - a database name to connect to.
```

Auth:

```
`SALT_ROUNDS` - a number of rounds to generate salt for hashing. Default: 10.
`JWT_SECRET`  - a secret for signing JWT tokens.
`JWT_TTL`     - an expiration time for JWT tokens (in ms format).
```

> More info on JWT_TTL format can be found [here](https://github.com/vercel/ms).

The variables must be set as environment variables or in a .env file.
The example .env file is available at `.env.example`.
Also, docker configuration for the default environment would be:

```dockerfile
ENV NODE_ENV=production

ENV HOST=localhost
ENV PORT=5000
ENV STATIC_PATH=/anthill/frontend

ENV DB=db_name
ENV DB_HOST=localhost
ENV DB_PORT=5432
ENV DB_USER=db_user
ENV DB_PASSWORD=db_user_password

ENV SALT_ROUNDS=10
ENV JWT_SECRET=your_secret
ENV JWT_TTL=18h
```

### Config

The system can be configured through changing values in the `config/common.yaml` file.
