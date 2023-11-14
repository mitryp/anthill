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
In bash, dots can not be used in variable names, so instead two underscores are used: `__`.
They will be replaced with dots at runtime.
For example, docker configuration for the default env would be:

```dockerfile
ENV NODE_ENV=production
ENV http__host=localhost
ENV http__port=5000
ENV http__staticPath=/anthill/frontend
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
