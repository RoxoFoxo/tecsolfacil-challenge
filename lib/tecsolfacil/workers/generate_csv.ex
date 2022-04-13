defmodule Tecsolfacil.Workers.GenerateCSV do
  use Oban.Worker, queue: :csv

  alias Tecsolfacil.Repo
  alias Tecsolfacil.Infos.Address

  @info_fields ~w[bairro cep complemento ddd gia ibge localidade logradouro siafi uf]a

  def perform(_obanjob) do
    Address
    |> Repo.all()
    |> Enum.map(&Map.take(&1, @info_fields))
    |> Enum.map(&Map.values(&1))
    |> then(fn x -> [@info_fields | x] end)
    |> CSV.encode()
    |> Enum.join()
    |> String.trim()

    :ok
  end
end
