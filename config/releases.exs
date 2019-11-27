import Config

config :gnome_grown, GnomeGrownWeb.Endpoint,
  server: true,
  # Needed for Phoenix 1.2 and 1.4. Doesn't hurt for 1.3.
  http: [port: {:system, "PORT"}],
  check_origin: false

config :gnome_grown, GnomeGrown.Repo,
  username: System.get_env("DB_USER"),
  database: System.get_env("DB_NAME"),
  password: System.get_env("DB_PASS") || nil,
  hostname: System.get_env("DB_HOST"),
  ssl: false,
  pool_size: 10
