# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tecsolfacil.Repo.insert!(%Tecsolfacil.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Tecsolfacil.Repo
alias Tecsolfacil.Accounts.User

%User{
  email: "test@example.com",
  hashed_password: Bcrypt.hash_pwd_salt("lol123456789")
}
|> Repo.insert!()
