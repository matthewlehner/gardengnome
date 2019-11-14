defmodule GnomeGrown.Reports.TimeSeries do
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
  def changeset(time_series, attrs) do
    time_series
    |> cast(attrs, [:temperature, :pressure, :humidity])
    |> validate_required([:temperature, :pressure, :humidity])
  end
end
