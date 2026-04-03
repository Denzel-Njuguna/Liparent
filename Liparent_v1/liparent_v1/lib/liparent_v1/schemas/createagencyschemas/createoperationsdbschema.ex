defmodule LiparentV1.Schemas.Createagencyschemas.Createoperationsdbschema do

    use Ecto.Schema
    import Ecto.Changeset
  @schema_prefix "agency"
  @primary_key {:operationsid, :binary_id, autogenerate: true}
    schema "areasofops" do
    field :agencyid, :binary_id
    field :countytown, :string        # 👈 single county, not a list
    field :residential, :boolean, default: false
    field :commercial, :boolean, default: false
    field :industrial, :boolean, default: false
    field :land, :boolean, default: false
  timestamps()
  end
  def changeset(areasofop, atts, agencyid) do
    areasofop
    |> cast(atts, [
      :countytown,
      :residential,
      :commercial,
      :industrial,
      :land
    ])
    |>put_change(:agencyid, agencyid)
    |>unique_constraint(:agencyid)
  end

end
