defmodule Tecsolfacil.InfosTest do
  use Tecsolfacil.DataCase

  import Tecsolfacil.Expectations

  alias Tecsolfacil.Infos
  alias Tecsolfacil.Infos.Address

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

  describe "get_address/1" do
    test "gets and saves info of an address and shows it when searched again" do
      expect_get_address({:ok, @address_info})

      cep = "01207-000"

      assert [] = Repo.all(Address)

      assert {:ok, result} = Infos.get_address(cep)
      assert result.cep == cep

      assert [address] = Repo.all(Address)
      assert address.cep == cep

      assert {:ok, result} = Infos.get_address(cep)
      assert result.cep == cep

      assert [address] = Repo.all(Address)
      assert address.cep == cep
    end

    test "gets and saves info of an address and shows it when searched again when cep has no hifen" do
      expect_get_address({:ok, @address_info})

      cep = "01207000"
      cep_hiphen = "01207-000"

      assert [] = Repo.all(Address)

      assert {:ok, result} = Infos.get_address(cep)
      assert result.cep == cep_hiphen

      assert [address] = Repo.all(Address)
      assert address.cep == cep_hiphen

      assert {:ok, result} = Infos.get_address(cep)
      assert result.cep == cep_hiphen

      assert [address] = Repo.all(Address)
      assert address.cep == cep_hiphen
    end

    test "does not save info when cep is invalid" do
      expect_get_address({:error, :bad_request})

      cep = "invalid-cep"

      assert [] = Repo.all(Address)

      assert {:error, :bad_request} = Infos.get_address(cep)

      assert [] = Repo.all(Address)
    end

    test "does not save info when cep is not found" do
      expect_get_address({:error, :not_found})

      cep = "00000000"

      assert [] = Repo.all(Address)

      assert {:error, :not_found} = Infos.get_address(cep)

      assert [] = Repo.all(Address)
    end
  end

  describe "create_address/1" do
    test "address ins't valid when cep isn't unique" do
      Infos.create_address(@address_info)

      assert {:error, changeset} = Infos.create_address(@address_info)
      refute changeset.valid?
    end
  end
end
