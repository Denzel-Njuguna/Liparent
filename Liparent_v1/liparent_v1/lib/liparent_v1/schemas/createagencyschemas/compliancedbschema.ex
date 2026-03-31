defmodule LiparentV1.Schemas.Createagencyschemas.Compliancedbschema do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix"agency"
  @primary_key{:compliance_id, :binary_id, autogenerate: false}
  schema "compliancetable" do
  field :earblicenceno, :string
  field :licenceexpirydate, :string
  field :incorporationno, :string
  field :agencyid, :binary_id
  field :singlebusinesspermitno, :string
  field :indemnityinsuranceprovider, :string
  field :policyexpirydate, :string
  field :trustaccountbank, :string
  field :trustaccountno, :string
  field :amlcompliance, :boolean
  end
  def changeset(compliance, params, agencyid) do
    compliance
    |>cast(params, [
    :earblicenceno,
    :licenceexpirydate,
    :incorporationno,
    :singlebusinesspermitno,
    :indemnityinsuranceprovider,
    :policyexpirydate,
    :trustaccountbank,
    :trustaccountno,
    :amlcompliance,
  ])
  |>put_change(:agencyid, agencyid)
  |> validate_required([
    :earblicenceno,
    :licenceexpirydate,
    :incorporationno,
    :singlebusinesspermitno,
    :indemnityinsuranceprovider,
    :policyexpirydate,
    :trustaccountbank,
    :trustaccountno,
    :amlcompliance,
  ])
  |>unique_constraint(:agencyid)
  end

end
