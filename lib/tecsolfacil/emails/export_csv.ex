defmodule Tecsolfacil.Emails.ExportCSV do
  @moduledoc false
  import Swoosh.Email

  def export(csv, email) do
    new()
    |> to(email)
    |> from({"Tecsolfacil", "tecsolfacil@example.com"})
    |> subject("CSV com todos nossos endereços")
    |> html_body("""
      <p>Aqui está um CSV com todos os endereços que temos até agora.</p>
    """)
    |> text_body("Aqui está um CSV com todos os endereços que temos até agora.")
    |> attachment(
      Swoosh.Attachment.new({:data, csv}, filename: "addresses.csv", content_type: "text/csv")
    )
  end
end
