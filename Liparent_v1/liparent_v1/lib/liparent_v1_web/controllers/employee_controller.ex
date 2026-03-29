defmodule LiparentV1Web.EmployeeController do
  use LiparentV1Web, :controller
  alias LiparentV1.Agencyemployeeaccount
  alias LiparentV1.Validation
  # def process_signup(conn, %{email: email, password: password}) do

  # end
  def process_login(conn, %{email: email, password: password}) do
    changeset = validate_login_data(%{email: email, password: password})
    case Ecto.Changeset.apply_action(changeset, :validate) do
      {:ok, valid} ->
        case Agencyemployeeaccount.authenticate_agency_employee(valid.email,valid.password) do
          {:ok,employee} ->
            # this is point when they move forward we collect the data to display for them in the frontend
            json(conn,%{status: "ok",username: employee.fullname})
          {:error, _reason} -> conn|>put_status(:unauthorized) |>json(%{status: "error", message: "user not found"})
        end
      {:error, failed_changeset} ->
        errors = Ecto.Changeset.traverse_errors(failed_changeset, fn {msg, _opts} -> msg end)
        conn |> put_status(:unprocessable_entity) |> json(%{status: "error", errors: errors})
    end
  end
  defp validate_login_data(params) do
    types = %{email: :string, password: :string}

    {%{}, types}
    |>Ecto.Changeset.cast(params,Map.keys(types))
    |>Ecto.Changeset.validate_required([:email,:password])
    |>Validation.validate_email(:email)
    |>Validation.validate_password_strength(:password)
  end
end
