defmodule Tecsolfacil.ViacepClient.API do
  @moduledoc false
  @behaviour Tecsolfacil.ViacepClient

  require Logger

  def get_address(cep) do
    Finch.build(:get, "https://viacep.com.br/ws/#{cep}/json/")
    |> Finch.request(ViacepFinch)
    |> handle_response()
  end

  defp handle_response(request) do
    Logger.debug(inspect(request, pretty: true))

    with {:ok, %{body: body, status: 200}} <- request,
         {:ok, decoded_body} <- Jason.decode(body) do
      {:ok, decoded_body}
    else
      {:ok, %{status: 404}} ->
        {:error, :not_found}

      {:ok, %{status: 400}} ->
        {:error, :bad_request}

      error ->
        Logger.error(inspect(error))
        {:error, :unkown_error}
    end
  end
end
