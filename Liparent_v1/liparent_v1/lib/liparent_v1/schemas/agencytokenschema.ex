defmodule LiparentV1.Schemas.Agencytokenschema do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key{:jti, :string, autogenerate: false}
  schema "agencytoken" do
    field :userid, :string
    field :token, :string
    field :agencyid, :string
    field :expires_at, :utc_datetime
    field :revoked, :boolean, default: false
    timestamps()
  end

  def changeset(schema,attrs) do
    schema
    |>cast(attrs, [:token, :userid,:jti,:agencyid ,:expires_at, :revoked])
    |>validate_required([:token, :userid, :jti,:agencyid, :expires_at, :revoked])
    |>unique_constraint(:userid)
  end
end
