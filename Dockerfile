FROM hexpm/elixir:1.13.4-erlang-23.3.4.9-alpine-3.14.2

WORKDIR /app

RUN apk add --no-progress --update libstdc++ openssl ncurses-libs build-base

COPY assets/ assets/
COPY config/ config/
COPY lib/ lib/
COPY priv/ priv/
COPY mix.exs .

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix deps.compile && \
    mix compile

CMD mix ecto.create && \
    mix ecto.migrate && \
    mix phx.server
