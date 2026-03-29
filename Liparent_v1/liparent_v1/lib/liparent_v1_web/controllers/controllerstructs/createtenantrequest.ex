defmodule LiparentV1Web.Controllerstructs.Createtenantrequest do
  alias LiparentV1Web.Controllerstructs.Createtenantrequest
  use Ecto.Schema
  alias LiparentV1.Validation
  import Ecto.Changeset

  embedded_schema do
    field :tenantid, Ecto.UUID
    field :fullname, :string
    field :buildingid, Ecto.UUID  # Fixed spelling
    field :buildingname, :string
    field :houseno, :string
    field :phonenumber, :string
    field :password, :string
  end

  def changeset(params) do
    %Createtenantrequest{}
    |> cast(params, [:tenantid, :fullname, :buildingid, :buildingname, :houseno, :phonenumber, :password])
    |> validate_required([:tenantid, :fullname, :buildingid, :buildingname, :houseno, :phonenumber, :password],
        message: "cannot be empty")
    |> Validation.validate_phone(:phonenumber)
    |> Validation.validate_password_strength(:password)
    |> Validation.validate_format_fields()
    |> Validation.validate_uuid(:tenantid)
    |> Validation.validate_uuid(:buildingid)
  end
end
