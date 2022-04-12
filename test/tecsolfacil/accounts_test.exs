defmodule Tecsolfacil.AccountsTest do
  use Tecsolfacil.DataCase

  import Tecsolfacil.AccountsFixtures

  alias Tecsolfacil.Accounts
  alias Tecsolfacil.Accounts.User

  @user_credentials %{
    email: "test@example.com",
    password: "very_long_password"
  }

  describe "create_user/1" do
    test "creates valid user" do
      Accounts.create_user(@user_credentials)

      assert [user] = Repo.all(User)
      assert user.email == "test@example.com"
    end

    test "doesn't create invalid user" do
      invalid_credentials = %{email: "invalid", password: "invalid"}

      assert {:error, changeset} = Accounts.create_user(invalid_credentials)
      assert Keyword.keys(changeset.errors) == [:password, :email]
      refute changeset.valid?
    end
  end

  describe "get_user_by_id/1" do
    test "valid id returns a user" do
      user = user_fixture()

      %User{id: id} = Accounts.get_user_by_id(user.id)

      assert id == user.id
    end

    test "invalid id returns nil" do
      invalid_id = 100

      result = Accounts.get_user_by_id(invalid_id)

      refute result
    end
  end
end
