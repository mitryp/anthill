# Anthill Front

This repo contains a Flutter frontend for Anthill charity management system.

Before the app can be run for the first time, make sure to run this in your shell of cmd while being
in the project folder:

```shell
$ dart run build_runner build && dart format . --line-length=100
```

Or, when using PowerShell:

```shell
dart run build_runner build ; dart format . --line-length=100
```

### Environment variables

#### Required

- `API_BASE_URI` - the url to access the Anthill backend API. Must include http schema.
  Default: `api/`.

#### Optional

- `FLUTTER_ENV` - either `production` or `development`. Default: `production`.

