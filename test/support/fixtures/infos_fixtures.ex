defmodule Tecsolfacil.InfosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tecsolfacil.Infos` context.
  """

  @doc """
  Generate a unique address cep.
  """
  def unique_address_cep, do: "some cep#{System.unique_integer([:positive])}"

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        cep: unique_address_cep()
      })
      |> Tecsolfacil.Infos.create_address()

    address
  end
end
