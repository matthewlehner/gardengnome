defmodule GnomeGrown.Repo.Migrations.AddMeasuredAtColumnToDataPoints do
  use Ecto.Migration

  def change do
    alter table(:data_points) do
      add(:measured_at, :utc_datetime)
    end
  end
end
