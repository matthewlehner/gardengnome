defmodule GnomeGrownWeb.TimeSeriesControllerTest do
  use GnomeGrownWeb.ConnCase

  alias GnomeGrown.Reports

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:time_series) do
    {:ok, time_series} = Reports.create_time_series(@create_attrs)
    time_series
  end

  describe "index" do
    test "lists all time_series", %{conn: conn} do
      conn = get(conn, Routes.time_series_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Time series"
    end
  end

  describe "new time_series" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.time_series_path(conn, :new))
      assert html_response(conn, 200) =~ "New Time series"
    end
  end

  describe "create time_series" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.time_series_path(conn, :create), time_series: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.time_series_path(conn, :show, id)

      conn = get(conn, Routes.time_series_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Time series"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.time_series_path(conn, :create), time_series: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Time series"
    end
  end

  describe "edit time_series" do
    setup [:create_time_series]

    test "renders form for editing chosen time_series", %{conn: conn, time_series: time_series} do
      conn = get(conn, Routes.time_series_path(conn, :edit, time_series))
      assert html_response(conn, 200) =~ "Edit Time series"
    end
  end

  describe "update time_series" do
    setup [:create_time_series]

    test "redirects when data is valid", %{conn: conn, time_series: time_series} do
      conn = put(conn, Routes.time_series_path(conn, :update, time_series), time_series: @update_attrs)
      assert redirected_to(conn) == Routes.time_series_path(conn, :show, time_series)

      conn = get(conn, Routes.time_series_path(conn, :show, time_series))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, time_series: time_series} do
      conn = put(conn, Routes.time_series_path(conn, :update, time_series), time_series: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Time series"
    end
  end

  describe "delete time_series" do
    setup [:create_time_series]

    test "deletes chosen time_series", %{conn: conn, time_series: time_series} do
      conn = delete(conn, Routes.time_series_path(conn, :delete, time_series))
      assert redirected_to(conn) == Routes.time_series_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.time_series_path(conn, :show, time_series))
      end
    end
  end

  defp create_time_series(_) do
    time_series = fixture(:time_series)
    {:ok, time_series: time_series}
  end
end
