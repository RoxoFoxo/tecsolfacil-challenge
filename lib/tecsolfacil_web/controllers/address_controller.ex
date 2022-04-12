defmodule TecsolfacilWeb.AddressController do
  use TecsolfacilWeb, :controller

  alias Tecsolfacil.Infos

  action_fallback TecsolfacilWeb.FallbackController

  def show(conn, %{"cep" => cep}) do
    with {:ok, address} <- Infos.get_address(cep) do
      render(conn, "show.json", address: address)
    end
  end
end
