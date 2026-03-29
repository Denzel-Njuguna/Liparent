defmodule LiparentV1Web.Controllerstructs.Createemployeerequest do
alias LiparentV1Web.Controllerstructs.Createemployeerequest
alias LiparentV1.Agencytokenmanager
alias LiparentV1.Validation

  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :fullname, :string
    field :token, :string
    field :password ,:string
    field :email, :string
    field :role, :string
    field :phonenumber,:string
    field :agencyid, Ecto.UUID
    field :createdby, Ecto.UUID
  end

  def changeset(params) do
    %Createemployeerequest{}
    |>cast(params, [:fullname, :token, :password, :email, :role, :phonenumber])
    |>validate_required([:fullname, :token, :password, :email, :role, :phonenumber])
    |>Validation.validate_password_strength(:password)
    |>Validation.validate_email(:email)
    |>validate_token(:token)
  end

  # here we retrieve the person creating the new employees's token validate it get the agencyid and also their id for fields agencyid and created by
  defp validate_token(changeset,field) do
    token = get_field(changeset,field)

    case Agencytokenmanager.verifytoken(token) do
      {:ok, claims} ->
        agencyid = claims["agencyid"]
        changeset
        |>put_change(:agencyid, agencyid)
        |>put_change(:createdby, claims["sub"])
      {:error, :session_expired} ->
        add_error(changeset, :token, "session is already expired")
    end
  end
end
