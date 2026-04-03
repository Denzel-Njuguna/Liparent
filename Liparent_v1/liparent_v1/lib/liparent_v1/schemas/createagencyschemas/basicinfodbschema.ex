defmodule LiparentV1.Schemas.Createagencyschemas.Basicinfodbschema do
  use Ecto.Schema
  import Ecto.Changeset
  @schema_prefix "agency"
  @primary_key{:agencyid, :binary_id, autogenerate: false}
  schema "agencybasicinfo" do
    field :agencyname, :string
    field :businessregno, :string
    field :yearestablished, :string
    field :agencytype, :string
    field :physicaladdress, :string
    field :phonenumber, :string
    field :businessemail, :string
    field :websiteurl, :string
  end

  def changeset(basicinfoschema,attrs) do
    basicinfoschema
    |>cast(attrs, [
    :agencyname,
    :businessregno,
    :yearestablished,
    :agencytype,
    :physicaladdress,
    :phonenumber,
    :businessemail,
    :websiteurl
  ])
  |> validate_required([:agencyname, :businessregno, :phonenumber, :businessemail,:yearestablished, :agencytype, :physicaladdress])
  |>unique_constraint([:businessregno, :phonenumber, :businessemail])
  end
end
