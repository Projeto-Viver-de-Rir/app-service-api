import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :viverderir_web, ViverderirWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "D3VdTDX8Vm7JYaktf/BM3tJ7BaOt6F2gHax1gBxV+N6Uc5w2BNAZmkAbb3I8AEKJ",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# In test we don't send emails.
config :viverderir, Viverderir.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
