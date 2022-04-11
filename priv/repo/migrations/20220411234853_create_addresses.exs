defmodule Tecsolfacil.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :cep, :string

      timestamps()
    end

    create unique_index(:addresses, [:cep])
  end
end
