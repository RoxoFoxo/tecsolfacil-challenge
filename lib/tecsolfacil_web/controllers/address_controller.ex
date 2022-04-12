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
    csv_data = Infos.list_addresses_into_csv()

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"export.csv\"")
    |> put_root_layout(false)
    |> send_resp(200, csv_data)
  end
end
