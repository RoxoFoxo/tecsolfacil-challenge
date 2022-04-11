defmodule Tecsolfacil.InfosTest do
  use Tecsolfacil.DataCase

  alias Tecsolfacil.Infos

  describe "addresses" do
    alias Tecsolfacil.Infos.Address

    import Tecsolfacil.InfosFixtures

    @invalid_attrs %{cep: nil}

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Infos.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Infos.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      valid_attrs = %{cep: "some cep"}

      assert {:ok, %Address{} = address} = Infos.create_address(valid_attrs)
      assert address.cep == "some cep"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Infos.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      update_attrs = %{cep: "some updated cep"}

      assert {:ok, %Address{} = address} = Infos.update_address(address, update_attrs)
      assert address.cep == "some updated cep"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Infos.update_address(address, @invalid_attrs)
      assert address == Infos.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Infos.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Infos.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Infos.change_address(address)
    end
  end
end
