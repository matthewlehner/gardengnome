defmodule GnomeGrownWeb.Router do
  use GnomeGrownWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GnomeGrownWeb do
    pipe_through :browser

    get "/", TimeSeriesController, :index
    resources "/reports", TimeSeriesController, only: [:index]
  end

  scope "/api/rest", GnomeGrownWeb do
    pipe_through :api

    resources "/data_points", DataPointController, except: [:new, :edit]
  end
end
