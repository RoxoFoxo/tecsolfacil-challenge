defmodule Tecsolfacil.Expectations do
  @moduledoc false
  import Hammox

  def expect_get_address(result) do
    Tecsolfacil.ViacepClient.Mock
    |> expect(:get_address, fn _ -> result end)
  end
end
