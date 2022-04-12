defmodule TecsolfacilWeb.AddressController do
  use TecsolfacilWeb, :controller

  alias Tecsolfacil.Infos

  action_fallback TecsolfacilWeb.FallbackController

  def show(conn, %{"id" => id}) do
    address = Infos.get_address!(id)
    render(conn, "show.json", address: address)
  end
end
