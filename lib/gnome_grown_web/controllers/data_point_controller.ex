defmodule GnomeGrownWeb.DataPointController do
  use GnomeGrownWeb, :controller

  alias GnomeGrown.Measurement
  alias GnomeGrown.Measurement.DataPoint

  action_fallback GnomeGrownWeb.FallbackController

  def index(conn, _params) do
    data_points = Measurement.list_data_points()
    render(conn, "index.json", data_points: data_points)
  end

  def create(conn, %{"data_point" => data_point_params}) do
    with {:ok, %DataPoint{} = data_point} <- Measurement.create_data_point(data_point_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.data_point_path(conn, :show, data_point))
      |> render("show.json", data_point: data_point)
    end
  end

  def show(conn, %{"id" => id}) do
    data_point = Measurement.get_data_point!(id)
    render(conn, "show.json", data_point: data_point)
  end

  def update(conn, %{"id" => id, "data_point" => data_point_params}) do
    data_point = Measurement.get_data_point!(id)

    with {:ok, %DataPoint{} = data_point} <- Measurement.update_data_point(data_point, data_point_params) do
      render(conn, "show.json", data_point: data_point)
    end
  end

  def delete(conn, %{"id" => id}) do
    data_point = Measurement.get_data_point!(id)

    with {:ok, %DataPoint{}} <- Measurement.delete_data_point(data_point) do
      send_resp(conn, :no_content, "")
    end
  end
end
