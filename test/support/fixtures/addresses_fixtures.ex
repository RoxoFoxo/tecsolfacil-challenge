defmodule Tecsolfacil.AddressesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tecsolfacil.Infos` context.
  """
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

  @doc """
  Generate an address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(@address_info)
      |> Tecsolfacil.Infos.create_address()

    address
  end
end
