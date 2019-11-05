defmodule GnomeGrownWeb.DataPointControllerTest do
  use GnomeGrownWeb.ConnCase

  alias GnomeGrown.Measurement
  alias GnomeGrown.Measurement.DataPoint

  @create_attrs %{
    humidity: 120.5,
    pressure: 120.5,
    temperature: 120.5
  }
  @update_attrs %{
    humidity: 456.7,
    pressure: 456.7,
    temperature: 456.7
  }
  @invalid_attrs %{humidity: nil, pressure: nil, temperature: nil}

  def fixture(:data_point) do
    {:ok, data_point} = Measurement.create_data_point(@create_attrs)
    data_point
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all data_points", %{conn: conn} do
      conn = get(conn, Routes.data_point_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create data_point" do
    test "renders data_point when data is valid", %{conn: conn} do
      conn = post(conn, Routes.data_point_path(conn, :create), data_point: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.data_point_path(conn, :show, id))

      assert %{
               "id" => id,
               "humidity" => 120.5,
               "pressure" => 120.5,
               "temperature" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.data_point_path(conn, :create), data_point: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update data_point" do
    setup [:create_data_point]

    test "renders data_point when data is valid", %{conn: conn, data_point: %DataPoint{id: id} = data_point} do
      conn = put(conn, Routes.data_point_path(conn, :update, data_point), data_point: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.data_point_path(conn, :show, id))

      assert %{
               "id" => id,
               "humidity" => 456.7,
               "pressure" => 456.7,
               "temperature" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, data_point: data_point} do
      conn = put(conn, Routes.data_point_path(conn, :update, data_point), data_point: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete data_point" do
    setup [:create_data_point]

    test "deletes chosen data_point", %{conn: conn, data_point: data_point} do
      conn = delete(conn, Routes.data_point_path(conn, :delete, data_point))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.data_point_path(conn, :show, data_point))
      end
    end
  end

  defp create_data_point(_) do
    data_point = fixture(:data_point)
    {:ok, data_point: data_point}
  end
end
