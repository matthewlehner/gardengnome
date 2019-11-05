defmodule GnomeGrown.Measurement do
  @moduledoc """
  The Measurement context.
  """

  import Ecto.Query, warn: false
  alias GnomeGrown.Repo

  alias GnomeGrown.Measurement.DataPoint

  @doc """
  Returns the list of data_points.

  ## Examples

      iex> list_data_points()
      [%DataPoint{}, ...]

  """
  def list_data_points do
    Repo.all(DataPoint)
  end

  @doc """
  Gets a single data_point.

  Raises `Ecto.NoResultsError` if the Data point does not exist.

  ## Examples

      iex> get_data_point!(123)
      %DataPoint{}

      iex> get_data_point!(456)
      ** (Ecto.NoResultsError)

  """
  def get_data_point!(id), do: Repo.get!(DataPoint, id)

  @doc """
  Creates a data_point.

  ## Examples

      iex> create_data_point(%{field: value})
      {:ok, %DataPoint{}}

      iex> create_data_point(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_data_point(attrs \\ %{}) do
    %DataPoint{}
    |> DataPoint.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a data_point.

  ## Examples

      iex> update_data_point(data_point, %{field: new_value})
      {:ok, %DataPoint{}}

      iex> update_data_point(data_point, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_data_point(%DataPoint{} = data_point, attrs) do
    data_point
    |> DataPoint.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DataPoint.

  ## Examples

      iex> delete_data_point(data_point)
      {:ok, %DataPoint{}}

      iex> delete_data_point(data_point)
      {:error, %Ecto.Changeset{}}

  """
  def delete_data_point(%DataPoint{} = data_point) do
    Repo.delete(data_point)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking data_point changes.

  ## Examples

      iex> change_data_point(data_point)
      %Ecto.Changeset{source: %DataPoint{}}

  """
  def change_data_point(%DataPoint{} = data_point) do
    DataPoint.changeset(data_point, %{})
  end
end
