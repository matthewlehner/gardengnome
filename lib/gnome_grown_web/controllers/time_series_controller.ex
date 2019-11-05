defmodule GnomeGrownWeb.TimeSeriesController do
  use GnomeGrownWeb, :controller

  alias GnomeGrown.Reports
  alias GnomeGrown.Reports.TimeSeries

  def index(conn, _params) do
    time_series = Reports.list_time_series()
    render(conn, "index.html", time_series: time_series)
  end

  def new(conn, _params) do
    changeset = Reports.change_time_series(%TimeSeries{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"time_series" => time_series_params}) do
    case Reports.create_time_series(time_series_params) do
      {:ok, time_series} ->
        conn
        |> put_flash(:info, "Time series created successfully.")
        |> redirect(to: Routes.time_series_path(conn, :show, time_series))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    time_series = Reports.get_time_series!(id)
    render(conn, "show.html", time_series: time_series)
  end

  def edit(conn, %{"id" => id}) do
    time_series = Reports.get_time_series!(id)
    changeset = Reports.change_time_series(time_series)
    render(conn, "edit.html", time_series: time_series, changeset: changeset)
  end

  def update(conn, %{"id" => id, "time_series" => time_series_params}) do
    time_series = Reports.get_time_series!(id)

    case Reports.update_time_series(time_series, time_series_params) do
      {:ok, time_series} ->
        conn
        |> put_flash(:info, "Time series updated successfully.")
        |> redirect(to: Routes.time_series_path(conn, :show, time_series))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", time_series: time_series, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    time_series = Reports.get_time_series!(id)
    {:ok, _time_series} = Reports.delete_time_series(time_series)

    conn
    |> put_flash(:info, "Time series deleted successfully.")
    |> redirect(to: Routes.time_series_path(conn, :index))
  end
end
