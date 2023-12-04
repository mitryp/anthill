FROM anthill_front as front-env

FROM node:16.20.1
ARG NODE_ENV="production"
ARG PORT=5000
ARG HOST="localhost"

ENV NODE_ENV=${NODE_ENV:-production}

ENV HOST=${HOST:-localhost}
ENV PORT=${PORT:-5000}
ENV STATIC_PATH=/anthill/frontend

RUN mkdir /anthill
RUN mkdir /anthill/backend
COPY . /anthill/backend

RUN mkdir /anthill/frontend
COPY --from=front-env /app/build/web/ /anthill/frontend

WORKDIR /anthill/backend

RUN npm install -y --omit=dev --loglevel warn
RUN npm install -y -g @nestjs/cli
RUN nest build

EXPOSE ${PORT}

CMD ["npm", "run", "start:prod"]