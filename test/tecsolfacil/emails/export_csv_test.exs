defmodule Tecsolfacil.Emails.ExportCSVTest do
  use Tecsolfacil.DataCase
  use Oban.Testing, repo: Tecsolfacil.Repo

  import Swoosh.TestAssertions

  alias Tecsolfacil.Workers.GenerateCSV

  describe "export/2" do
    test "sends email when job is performed" do
      client_email = "test@example.com"

      perform_job(GenerateCSV, %{email: client_email})

      assert_email_sent()
    end
  end
end
