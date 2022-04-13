defmodule TecsolfacilWeb.AddressController do
  use TecsolfacilWeb, :controller

  alias Tecsolfacil.Infos

  action_fallback TecsolfacilWeb.FallbackController

  def show(conn, %{"cep" => cep}) do
    # %{email: email} = Guardian.Plug.current_resource(conn)

    with {:ok, address} <- Infos.get_address(cep) do
      render(conn, "show.json", address: address)
    end
  end

  # Temporary
  def export(conn, _params) do
    Infos.list_addresses_into_csv()

    # Edit view later, make it look more professional or something
    render(conn, "export.json")
  end
end
