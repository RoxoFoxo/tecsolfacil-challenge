defmodule TecsolfacilWeb.AddressController do
  use TecsolfacilWeb, :controller

  alias Tecsolfacil.Infos
  alias Tecsolfacil.Infos.Address

  action_fallback TecsolfacilWeb.FallbackController

  def index(conn, _params) do
    addresses = Infos.list_addresses()
    render(conn, "index.json", addresses: addresses)
  end

  def create(conn, %{"address" => address_params}) do
    with {:ok, %Address{} = address} <- Infos.create_address(address_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.address_path(conn, :show, address))
      |> render("show.json", address: address)
    end
  end

  def show(conn, %{"id" => id}) do
    address = Infos.get_address!(id)
    render(conn, "show.json", address: address)
  end

  def update(conn, %{"id" => id, "address" => address_params}) do
    address = Infos.get_address!(id)

    with {:ok, %Address{} = address} <- Infos.update_address(address, address_params) do
      render(conn, "show.json", address: address)
    end
  end

  def delete(conn, %{"id" => id}) do
    address = Infos.get_address!(id)

    with {:ok, %Address{}} <- Infos.delete_address(address) do
      send_resp(conn, :no_content, "")
    end
  end
end
