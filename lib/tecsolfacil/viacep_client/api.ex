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
         {:ok, %{"cep" => _cep} = decoded_body} <- Jason.decode(body) do
      {:ok, decoded_body}
    else
      # Someone decided it would be cool to make it randomly return
      # "true" either as a boolean or string from the API when CEP is invalid.
      # Seriously, just check these two links:
      # https://viacep.com.br/ws/00000000/json/
      # https://viacep.com.br/ws/99999999/json/
      {:ok, %{"erro" => _true}} ->
        {:error, :not_found}

      {:ok, %{status: 400}} ->
        {:error, :bad_request}

      error ->
        Logger.error(inspect(error))
        {:error, :unknown_error}
    end
  end
end
