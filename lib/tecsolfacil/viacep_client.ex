defmodule Tecsolfacil.ViacepClient do
  @moduledoc false
  @callback get_address(String.t()) :: {:ok | :error, map() | atom()}
  @adapter Application.compile_env(:tecsolfacil, :viacep_client, Tecsolfacil.ViacepClient.API)

  def get_address(cep) do
    @adapter.get_address(cep)
  end
end
