defmodule Tecsolfacil.Infos.Address do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w[cep logradouro complemento bairro localidade uf ibge gia ddd siafi]a

  schema "addresses" do
    field :cep, :string
    field :logradouro, :string
    field :complemento, :string
    field :bairro, :string
    field :localidade, :string
    field :uf, :string
    field :ibge, :string
    field :gia, :string
    field :ddd, :string
    field :siafi, :string

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, @fields)
    |> validate_required([:cep])
    |> unique_constraint(:cep)
  end
end
