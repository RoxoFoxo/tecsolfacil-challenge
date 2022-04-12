defmodule TecsolfacilWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use TecsolfacilWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(TecsolfacilWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(TecsolfacilWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(TecsolfacilWeb.ErrorView)
    |> render(:"400")
  end

  def call(conn, {:error, :unknown_error}) do
    conn
    |> put_status(500)
    |> put_view(TecsolfacilWeb.ErrorView)
    |> render(:"500")
  end

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_status(:unauthorized)
    |> put_view(TecsolfacilWeb.ErrorView)
    |> render(:"401")
  end
end
