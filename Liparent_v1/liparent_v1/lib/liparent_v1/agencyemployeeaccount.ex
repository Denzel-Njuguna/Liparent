defmodule LiparentV1.Agencyemployeeaccount do
  alias LiparentV1.Repo
  alias LiparentV1.Schemas.Agencyemployeeschema

  def register_agency_employee(attrs) do        # keep as 1 arg, fix the controller call instead
    case Agencyemployeeschema.registration_changeset(attrs) |> Repo.insert() do
      {:ok, employee} -> {:ok, employee}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def authenticate_agency_employee(email, password) do
    case Repo.get_by(Agencyemployeeschema, email: String.downcase(email)) do
      nil ->
        Bcrypt.no_user_verify()               # FIX: prevents timing attacks — always run verify even if no user found
        {:error, "invalid login credentials"}

      employee ->
        if Bcrypt.verify_pass(password, employee.password_hash) do
          {:ok, employee}
        else
          {:error, "invalid login credentials"}
        end
    end
  end
end
