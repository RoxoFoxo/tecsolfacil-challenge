defmodule Tecsolfacil.Workers.GenerateCSV do
  @moduledoc false
  use Oban.Worker, queue: :csv

  alias Tecsolfacil.Emails.ExportCSV
  alias Tecsolfacil.Infos.Address
  alias Tecsolfacil.Mailer
  alias Tecsolfacil.Repo

  @info_fields ~w[bairro cep complemento ddd gia ibge localidade logradouro siafi uf]a

  def perform(%Oban.Job{args: %{"email" => email}}) do
    generated_csv = generate_csv()

    generated_csv
    |> ExportCSV.export(email)
    |> Mailer.deliver()

    {:ok, generated_csv}
  end

  defp generate_csv do
    Address
    |> Repo.all()
    |> Enum.map(&Map.take(&1, @info_fields))
    |> Enum.map(&Map.values(&1))
    |> then(fn x -> [@info_fields | x] end)
    |> CSV.encode()
    |> Enum.join()
    |> String.trim()
  end
end
