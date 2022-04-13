defmodule Tecsolfacil.Infos do
  @moduledoc """
  The Infos context.
  """

  import Ecto.Query, warn: false

  alias Tecsolfacil.Infos.Address
  alias Tecsolfacil.Repo
  alias Tecsolfacil.ViacepClient
  alias Tecsolfacil.Workers.GenerateCSV

  @doc """
  Gets a single address.

  Raises `Ecto.NoResultsError` if the Address does not exist.

  ## Examples

      iex> get_address!(123)
      %Address{}

      iex> get_address!(456)
      ** (Ecto.NoResultsError)

  """
  def get_address(cep) do
    cep = handle_cep(cep)

    with nil <- Repo.get_by(Address, cep: cep),
         {:ok, result} <- ViacepClient.get_address(cep) do
      create_address(result)
    else
      {:error, reason} ->
        {:error, reason}

      address ->
        {:ok, address}
    end
  end

  defp handle_cep(cep) do
    if String.match?(cep, ~r'-') do
      cep
    else
      cep
      |> String.split_at(5)
      |> then(fn {x, y} -> x <> "-" <> y end)
    end
  end

  @doc """
  Creates a address.

  ## Examples

      iex> create_address(%{field: value})
      {:ok, %Address{}}

      iex> create_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_address(attrs \\ %{}) do
    %Address{}
    |> Address.changeset(attrs)
    |> Repo.insert()
  end

  def list_addresses_into_csv(email) do
    %{email: email}
    |> GenerateCSV.new()
    |> Oban.insert()
  end
end
