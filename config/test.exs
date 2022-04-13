import Config

config :tecsolfacil, Oban, testing: :inline

config :tecsolfacil, :viacep_client, Tecsolfacil.ViacepClient.Mock

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :tecsolfacil, Tecsolfacil.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "tecsolfacil_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tecsolfacil, TecsolfacilWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "xIHLVE1pP/EnNPO219u66vYb3TYpHvMbhgZWWgswUqa/ESc9CmL+HBZc5CRy6W7B",
  server: false

# In test we don't send emails.
config :tecsolfacil, Tecsolfacil.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
