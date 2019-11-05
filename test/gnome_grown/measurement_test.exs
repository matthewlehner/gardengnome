defmodule GnomeGrown.MeasurementTest do
  use GnomeGrown.DataCase

  alias GnomeGrown.Measurement

  describe "data_points" do
    alias GnomeGrown.Measurement.DataPoint

    @valid_attrs %{humidity: 120.5, pressure: 120.5, temperature: 120.5}
    @update_attrs %{humidity: 456.7, pressure: 456.7, temperature: 456.7}
    @invalid_attrs %{humidity: nil, pressure: nil, temperature: nil}

    def data_point_fixture(attrs \\ %{}) do
      {:ok, data_point} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Measurement.create_data_point()

      data_point
    end

    test "list_data_points/0 returns all data_points" do
      data_point = data_point_fixture()
      assert Measurement.list_data_points() == [data_point]
    end

    test "get_data_point!/1 returns the data_point with given id" do
      data_point = data_point_fixture()
      assert Measurement.get_data_point!(data_point.id) == data_point
    end

    test "create_data_point/1 with valid data creates a data_point" do
      assert {:ok, %DataPoint{} = data_point} = Measurement.create_data_point(@valid_attrs)
      assert data_point.humidity == 120.5
      assert data_point.pressure == 120.5
      assert data_point.temperature == 120.5
    end

    test "create_data_point/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Measurement.create_data_point(@invalid_attrs)
    end

    test "update_data_point/2 with valid data updates the data_point" do
      data_point = data_point_fixture()
      assert {:ok, %DataPoint{} = data_point} = Measurement.update_data_point(data_point, @update_attrs)
      assert data_point.humidity == 456.7
      assert data_point.pressure == 456.7
      assert data_point.temperature == 456.7
    end

    test "update_data_point/2 with invalid data returns error changeset" do
      data_point = data_point_fixture()
      assert {:error, %Ecto.Changeset{}} = Measurement.update_data_point(data_point, @invalid_attrs)
      assert data_point == Measurement.get_data_point!(data_point.id)
    end

    test "delete_data_point/1 deletes the data_point" do
      data_point = data_point_fixture()
      assert {:ok, %DataPoint{}} = Measurement.delete_data_point(data_point)
      assert_raise Ecto.NoResultsError, fn -> Measurement.get_data_point!(data_point.id) end
    end

    test "change_data_point/1 returns a data_point changeset" do
      data_point = data_point_fixture()
      assert %Ecto.Changeset{} = Measurement.change_data_point(data_point)
    end
  end
end
