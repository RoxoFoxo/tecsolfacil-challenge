defmodule TecsolfacilWeb.AddressView do
  use TecsolfacilWeb, :view
  alias TecsolfacilWeb.AddressView

  def render("show.json", %{address: address}) do
    render_one(address, AddressView, "address.json")
  end

  def render("address.json", %{address: address}) do
    %{
      cep: address.cep
    }
  end
end
