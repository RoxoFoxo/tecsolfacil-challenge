defmodule Tecsolfacil.Workers.GenerateCSVTest do
  use Tecsolfacil.DataCase
  use Oban.Testing, repo: Tecsolfacil.Repo

  import Tecsolfacil.AddressesFixtures

  alias Tecsolfacil.Workers.GenerateCSV

  @csv_string "bairro,cep,complemento,ddd,gia,ibge,localidade,logradouro,siafi,uf\r\nSanta Efigênia,01207-000,lado par,11,1004,3550308,São Paulo,Rua Santa Efigênia,7107,SP"

  describe "perform/1" do
    test "generates correct csv string" do
      address_fixture()

      email = "test@example.com"

      assert {:ok, generated_csv} = perform_job(GenerateCSV, %{email: email})
      assert generated_csv == @csv_string
    end
  end
end
