FROM elixir:1.15.4-alpine

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY . .

RUN mix do deps.get, deps.compile

CMD ["mix", "phx.server"]