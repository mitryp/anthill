ARG FLUTTER_ENV=production

FROM ghcr.io/cirruslabs/flutter:3.13.9

COPY . /app/

WORKDIR /app/

RUN flutter build web --dart-define FLUTTER_ENV=${FLUTTER_ENV}
