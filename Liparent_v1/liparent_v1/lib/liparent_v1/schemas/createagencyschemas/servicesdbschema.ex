defmodule LiparentV1.Schemas.Createagencyschemas.Servicesdbschema do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "agency"
  @primary_key{:servicesid, :binary_id, autogenerate: false}
  schema "servicesoffered" do
    field :propertylettings, :boolean
    field :propertymanagement, :boolean
    field :shorttermmanagement, :boolean
    field :commercialleasing, :boolean
    field :agencyid, :binary_id
  end

  def changeset(services, attrs, agencyid) do
    services
    |> cast(attrs, [
      :propertylettings,
      :propertymanagement,
      :shorttermmanagement,
      :commercialleasing
      ])
      |>put_change(:agencyid, agencyid)
      |>unique_constraint(:agencyid)
  end

end
