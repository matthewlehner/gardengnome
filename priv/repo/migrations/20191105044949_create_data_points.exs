defmodule GnomeGrown.Repo.Migrations.CreateDataPoints do
  use Ecto.Migration

  def change do
    create table(:data_points) do
      add :temperature, :float
      add :pressure, :float
      add :humidity, :float

      timestamps()
    end

  end
end
