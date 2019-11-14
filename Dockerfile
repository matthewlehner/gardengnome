FROM elixir:1.9-alpine as build

# install build dependencies
RUN apk add --update git build-base nodejs yarn python

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod
ENV NODE_ENV=production

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get
RUN mix deps.compile

# build assets
COPY lib lib
COPY assets assets
RUN cd assets && yarn install --production=false && yarn deploy
RUN mix phx.digest

# build project
COPY priv priv
RUN mix compile

# build release
COPY config/prod.exs config/prod.exs
COPY config/releases.exs config/releases.exs
RUN mix release

# prepare release image
FROM alpine:3.9 AS app
RUN apk add --update bash openssl

RUN mkdir /app
WORKDIR /app

COPY --from=build /app/_build/prod/rel/gnome_grown ./
RUN chown -R nobody: /app
USER nobody

ENV HOME=/app
ENTRYPOINT [ "bin/gnome_grown" ]
CMD [ "start" ]
