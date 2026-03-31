defmodule LiparentV1.Schemas.Createagencyschemas.Createoperationsdbschema do

    use Ecto.Schema
    import Ecto.Changeset
  @schema_prefix "agency"
  @primary_key{:operationsid, :binary_id, autogenerate: false}
  schema "areasofops" do
  field :countiestownsserved, :string
  field :agencyid, :binary_id
  field :residential, :boolean
  field :commercial, :boolean
  field :industrial, :boolean
  field :land, :boolean
  end
  def changeset(areasofop, atts, agencyid) do
    areasofop
    |> cast(atts, [
      :countiestownsserved,
      :residential,
      :commercial,
      :industrial,
      :land
    ])
    |>put_change(:agencyid, agencyid)
    |>unique_constraint(:agencyid)
  end

end
