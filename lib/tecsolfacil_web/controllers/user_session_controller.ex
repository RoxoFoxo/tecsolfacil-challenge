defmodule TecsolfacilWeb.UserSessionController do
  use TecsolfacilWeb, :controller

  alias Tecsolfacil.Accounts
  alias Tecsolfacil.Guardian

  action_fallback TecsolfacilWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    if user = Accounts.get_user_by_email_and_password(email, password) do
      {:ok, token, _claims} = Guardian.encode_and_sign(user, %{typ: "access"}, ttl: {1, :hour})

      conn
      |> put_status(:ok)
      |> render("token.json", %{token: token})
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(TecsolfacilWeb.ErrorView)
      |> render(:"401")
    end
  end
end
