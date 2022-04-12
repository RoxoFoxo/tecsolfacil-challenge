defmodule Tecsolfacil.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Plugfacil.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "test@example.com",
        password: "very_long_password"
      })
      |> Tecsolfacil.Accounts.create_user()

    user
  end
end

