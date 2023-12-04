# Anthill Backend

A backend of Anthill charity accounting system.

## Configuration

### Environment

The following environment variables are required:

```
`NODE_ENV` - default: "development"
`http.`
    `host` - a http ip of the nest server to serve on
    `port` - a port for the nest server to serve on
    `staticPath` - a path to the built Anthill frontend directory
```

The variables can be set as environment variables or in the `config` directory, in the file
named corresponding to the `NODE_ENV` value.

As env variables, the names should not include the yaml group, and the names should be transformed into screaming case.
For example, docker configuration for the default env would be:

```dockerfile
ENV NODE_ENV=production

ENV HOST=localhost
ENV PORT=5000
ENV STATIC_PATH=/anthill/frontend
```

Or, in `config/development.yaml`:

```yaml
http:
  host: localhost
  port: 5000
  staticPath: /anthill/frontend
```

### Config

The system can be configured through changing values in the `config/common.yaml` file.
