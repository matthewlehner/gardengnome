use Mix.Config

# Configure your database
config :gnome_grown, GnomeGrown.Repo,
  username: System.get_env("DB_USER"),
  database: "growbud_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gnome_grown, GnomeGrownWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
