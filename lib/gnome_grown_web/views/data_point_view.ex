defmodule GnomeGrownWeb.DataPointView do
  use GnomeGrownWeb, :view
  alias GnomeGrownWeb.DataPointView

  def render("index.json", %{data_points: data_points}) do
    %{data: render_many(data_points, DataPointView, "data_point.json")}
  end

  def render("show.json", %{data_point: data_point}) do
    %{data: render_one(data_point, DataPointView, "data_point.json")}
  end

  def render("data_point.json", %{data_point: data_point}) do
    %{id: data_point.id,
      temperature: data_point.temperature,
      pressure: data_point.pressure,
      humidity: data_point.humidity}
  end
end
