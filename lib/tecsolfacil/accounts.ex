defmodule Tecsolfacil.Accounts do
  @moduledoc false
  import Ecto.Query, warn: false
  alias Tecsolfacil.Repo

  alias Tecsolfacil.Accounts.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user_by_id(id), do: Repo.get(User, id)

  def get_user_by_email_and_password(email, password)
      when is_binary(email) and is_binary(password) do
    with %User{hashed_password: hashed_password} = user <- Repo.get_by(User, email: email),
         true <- Bcrypt.verify_pass(password, hashed_password) do
      user
    else
      _ -> nil
    end
  end
end
