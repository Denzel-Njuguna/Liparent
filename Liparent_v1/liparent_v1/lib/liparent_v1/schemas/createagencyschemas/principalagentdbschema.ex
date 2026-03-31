defmodule LiparentV1.Schemas.Createagencyschemas.Principalagentdbschema do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "agency"
  @primary_key{:principalagentid, :binary_id, autogenerate: false}
  schema "principalagenttable" do
  field :fullname, :string
  field :nationalid, :string
  field :employeeid, :binary_id
  field :earbregistration, :string
  field :iskmembership, :string
  field :krapin, :string
  field :password, :string
  field :practisingcertno, :string
  field :certexpirydate, :string
  end
# test case here is if the same employee creates more that one schema
  def changeset(principalagent, atts, :employeeid) do
    principalagent
    |> cast(atts, [
    :fullname,
    :nationalid,
    :earbregistration,
    :iskmembership,
    :password,
    :krapin,
    :practisingcertno,
    :certexpirydate
  ])
  |> validate_required([:fullname, :nationalid,:password,:earbregistration,:iskmembership,:krapin,:practisingcertno,:certexpirydate,:employeeid])
  # we put unique constraint here so incase of an error we have a standardised error instead or a raw sql query
  |> unique_constraint(:employeeid)
  |>put_change(:employeeid, :employeeid)
  end

end
