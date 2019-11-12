defmodule GnomeGrown.ReportsTest do
  use GnomeGrown.DataCase

  alias GnomeGrown.Reports

  describe "time_series" do
    alias GnomeGrown.Reports.TimeSeries

    @valid_attrs %{
      temperature: 24.50,
      pressure: 1234.01,
      humidity: 0.45,
      measured_at: DateTime.utc_now()
    }
    @update_attrs %{}
    @invalid_attrs %{humidity: nil, pressure: nil, temperature: nil, measured_at: nil}

    def time_series_fixture(attrs \\ %{}) do
      {:ok, time_series} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reports.create_time_series()

      time_series
    end

    test "list_time_series/0 returns all time_series" do
      time_series = time_series_fixture()
      assert Reports.list_time_series() == [time_series]
    end

    test "get_time_series!/1 returns the time_series with given id" do
      time_series = time_series_fixture()
      assert Reports.get_time_series!(time_series.id) == time_series
    end

    test "create_time_series/1 with valid data creates a time_series" do
      assert {:ok, %TimeSeries{} = time_series} = Reports.create_time_series(@valid_attrs)
    end

    test "create_time_series/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reports.create_time_series(@invalid_attrs)
    end

    test "update_time_series/2 with valid data updates the time_series" do
      time_series = time_series_fixture()

      assert {:ok, %TimeSeries{} = time_series} =
               Reports.update_time_series(time_series, @update_attrs)
    end

    test "update_time_series/2 with invalid data returns error changeset" do
      time_series = time_series_fixture()
      assert {:error, %Ecto.Changeset{}} = Reports.update_time_series(time_series, @invalid_attrs)
      assert time_series == Reports.get_time_series!(time_series.id)
    end

    test "delete_time_series/1 deletes the time_series" do
      time_series = time_series_fixture()
      assert {:ok, %TimeSeries{}} = Reports.delete_time_series(time_series)
      assert_raise Ecto.NoResultsError, fn -> Reports.get_time_series!(time_series.id) end
    end

    test "change_time_series/1 returns a time_series changeset" do
      time_series = time_series_fixture()
      assert %Ecto.Changeset{} = Reports.change_time_series(time_series)
    end
  end
end
