defmodule GnomeGrown.Repo do
  use Ecto.Repo,
    otp_app: :gnome_grown,
    adapter: Ecto.Adapters.Postgres
end
