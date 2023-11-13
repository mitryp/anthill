FROM anthill_front as front-env

ARG PORT=5000
FROM node:16.20.1

ENV NODE_ENV=docker

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