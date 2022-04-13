defmodule TecsolfacilWeb.AddressControllerTest do
  use TecsolfacilWeb.ConnCase

  import Tecsolfacil.AccountsFixtures
  import Tecsolfacil.Expectations
  import Tecsolfacil.Guardian

  @address_info %{
    "bairro" => "Santa Efigênia",
    "cep" => "01207-000",
    "complemento" => "lado par",
    "ddd" => "11",
    "gia" => "1004",
    "ibge" => "3550308",
    "localidade" => "São Paulo",
    "logradouro" => "Rua Santa Efigênia",
    "siafi" => "7107",
    "uf" => "SP"
  }

  describe "show/2" do
    test "shows a cep's info when token is valid", %{conn: conn} do
      expect_get_address({:ok, @address_info})

      user = user_fixture()
      {:ok, token, _claims} = encode_and_sign(user, %{typ: "access"})

      cep = "01207-000"

      result =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> get(Routes.api_address_path(conn, :show, cep))
        |> json_response(200)

      assert result == @address_info
    end

    test "returns bad_request error when cep is invalid", %{conn: conn} do
      expect_get_address({:error, :bad_request})

      user = user_fixture()
      {:ok, token, _claims} = encode_and_sign(user, %{typ: "access"})

      cep = "invalid-cep"

      result =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> get(Routes.api_address_path(conn, :show, cep))
        |> json_response(400)

      assert result == %{"errors" => %{"detail" => "Bad Request"}}
    end

    test "returns not_found error when cep doesn't exist", %{conn: conn} do
      expect_get_address({:error, :not_found})

      user = user_fixture()
      {:ok, token, _claims} = encode_and_sign(user, %{typ: "access"})

      cep = "00000000"

      result =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> get(Routes.api_address_path(conn, :show, cep))
        |> json_response(404)

      assert result == %{"errors" => %{"detail" => "Not Found"}}
    end

    test "returns unauthorized error when token is invalid", %{conn: conn} do
      invalid_token = "invalid token"

      cep = "01207-000"

      result =
        conn
        |> put_req_header("authorization", "Bearer " <> invalid_token)
        |> get(Routes.api_address_path(conn, :show, cep))
        |> json_response(401)

      assert result == %{"errors" => %{"detail" => "Unauthorized"}}
    end
  end

  describe "export/2" do
    test "returns accepted when token is valid", %{conn: conn} do
      user = user_fixture()
      {:ok, token, _claims} = encode_and_sign(user, %{typ: "access"})

      result =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> get(Routes.api_address_path(conn, :export))
        |> json_response(202)

      assert result == %{"detail" => "Accepted"}
    end

    test "returns unauthorized when token is invalid", %{conn: conn} do
      invalid_token = "invalid token"

      result =
        conn
        |> put_req_header("authorization", "Bearer " <> invalid_token)
        |> get(Routes.api_address_path(conn, :export))
        |> json_response(401)

      assert result == %{"errors" => %{"detail" => "Unauthorized"}}
    end
  end
end
