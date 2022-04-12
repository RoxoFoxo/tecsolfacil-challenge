defmodule Tecsolfacil.Guardian do
  @moduledoc false
  use Guardian, otp_app: :tecsolfacil

  alias Tecsolfacil.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :invalid_id}
  end

  def resource_from_claims(%{"sub" => id}) do
    resource = Accounts.get_user_by_id(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :invalid_token}
  end
end
