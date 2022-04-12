defmodule TecsolfacilWeb.UserSessionControllerTest do
  use TecsolfacilWeb.ConnCase

  import Tecsolfacil.AccountsFixtures

  @user_credentials %{
    email: "test@example.com",
    password: "very_long_password"
  }

  describe "create/2" do
    test "creates a user session and gives them a token", %{conn: conn} do
      user_fixture()

      conn = post(conn, Routes.api_user_session_path(conn, :create, @user_credentials))

      assert %{"token" => _token} = json_response(conn, 200)
    end

    test "shows unauthorized error for an invalid login", %{conn: conn} do
      conn = post(conn, Routes.api_user_session_path(conn, :create, @user_credentials))

      assert response(conn, 401)
    end
  end
end
