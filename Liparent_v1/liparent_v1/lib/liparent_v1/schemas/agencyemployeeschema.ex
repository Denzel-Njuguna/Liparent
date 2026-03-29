defmodule LiparentV1.Schemas.Agencyemployeeschema do
  alias LiparentV1.Schemas.Agencyemployeeschema
  use Ecto.Schema
  import Ecto.Changeset

# this is the schema for agency login
  @schema_prefix "agency"
  @primary_key {:employeeid, :binary_id, autogenerate: true}
  schema "agencyemployee" do
    field :fullname, :string
    field :email, :string
    field :agencyid, Ecto.UUID
    field :phonenumber, :string
    field :createdby, Ecto.UUID
    field :password, :string
    field :role, :string
  end

  @spec registration_changeset(
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def registration_changeset(attr) do
    %Agencyemployeeschema{}
    |>cast(attr, [:fullname, :agencyid,:email, :phonenumber, :role, :createdby, :password])
    |>validate_required([:fullname, :agencyid,:email, :phonenumber, :role, :createdby, :password])
    |>hash_password()

  end
  defp hash_password(changeset) do
      if password = get_change(changeset, :password) do
        changeset
        |>put_change(:password, Bcrypt.hash_pwd_salt(password))
        |>delete_change(:password)
      else
        changeset
      end
  end

end
