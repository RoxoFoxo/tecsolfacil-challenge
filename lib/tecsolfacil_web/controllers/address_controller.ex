defmodule TecsolfacilWeb.AddressController do
  use TecsolfacilWeb, :controller

  alias Tecsolfacil.Infos

  action_fallback TecsolfacilWeb.FallbackController

  def show(conn, %{"cep" => cep}) do
    with {:ok, address} <- Infos.get_address(cep) do
      render(conn, "show.json", address: address)
    end
  end

  def export(conn, _params) do
    %{email: email} = Guardian.Plug.current_resource(conn)

    Infos.list_addresses_into_csv(email)

    conn
    |> put_status(202)
    |> render("export.json")
  end
end
