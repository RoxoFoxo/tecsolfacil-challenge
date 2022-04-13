defmodule TecsolfacilWeb.AddressView do
  use TecsolfacilWeb, :view
  alias TecsolfacilWeb.AddressView

  def render("show.json", %{address: address}) do
    render_one(address, AddressView, "address.json")
  end

  def render("address.json", %{address: a}) do
    %{
      cep: a.cep,
      logradouro: a.logradouro,
      complemento: a.complemento,
      bairro: a.bairro,
      localidade: a.localidade,
      uf: a.uf,
      ibge: a.ibge,
      gia: a.gia,
      ddd: a.ddd,
      siafi: a.siafi
    }
  end

  def render("export.json", _params) do
    %{
      message: "Um email com o CSV de todos os endereços será enviado para você"
    }
  end
end
