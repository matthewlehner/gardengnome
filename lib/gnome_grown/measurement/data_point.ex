defmodule GnomeGrown.Measurement.DataPoint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "data_points" do
    field :humidity, :float
    field :pressure, :float
    field :temperature, :float
    field :measured_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(data_point, attrs) do
    data_point
    |> cast(attrs, [:temperature, :pressure, :humidity, :measured_at])
    |> validate_required([:temperature, :pressure, :humidity, :measured_at])
  end
end
