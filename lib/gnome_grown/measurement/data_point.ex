defmodule GnomeGrown.Measurement.DataPoint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "data_points" do
    field :humidity, :float
    field :pressure, :float
    field :temperature, :float

    timestamps()
  end

  @doc false
  def changeset(data_point, attrs) do
    data_point
    |> cast(attrs, [:temperature, :pressure, :humidity])
    |> validate_required([:temperature, :pressure, :humidity])
  end
end
