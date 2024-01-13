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

#### Optional

- `API_HOST` - the url to access the root endpoint of Anthill backend. Can be relative or absolute
  (in this case, must include a HTTP schema). Default: `/` (the root of the same host).
- `FLUTTER_ENV` - either `production` or `development`. Default: `production`.

