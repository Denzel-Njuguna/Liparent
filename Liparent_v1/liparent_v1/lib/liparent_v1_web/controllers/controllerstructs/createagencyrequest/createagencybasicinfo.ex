defmodule LiparentV1Web.Controllerstructs.Createagencyrequest.Createagencybasicinfo do
  alias LiparentV1.Validation
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :agencyname, :string
    field :businessregno, :string
    field :yearestablished, :string
    field :agencytype, :string
    field :physicaladdress, :string
    field :phonenumber, :string
    field :businessemail, :string
    field :websiteurl, :string
  end

  def basic_info_changeset(basicinfo, params) do
  basicinfo
  |> cast(params, [
    :agencyname,
    :businessregno,
    :yearestablished,
    :agencytype,
    :physicaladdress,
    :postaladdress,
    :phonenumber,
    :businessemail,
    :websiteurl
  ])
  |> validate_required([:agencyname, :businessregno, :phonenumber, :businessemail,:yearestablished, :agencytype, :physicaladdress])
  |>Validation.validate_email(:businessemail)
  |>Validation.validate_phone(:phonenumber)
  |>Validation.validate_string_name(:agencyname)
  |>Validation.validate_string_name(:physicaladdress)
  |>Validation.validate_string_name(:postaladdress)
  |>validate_website_url(:websiteurl,required: false, allow_blank: true)
  |>validate_inclusion(:agencytype,["sole proprietorship", "limited company", "partnership"])
  # look into adding one for business reg no

end
# TODO: check on how attacks can happen based from user entering a website url
  defp validate_website_url(changeset, field, opts \\ []) do
  required = Keyword.get(opts, :required, false)
  _allow_blank = Keyword.get(opts, :allow_blank, true)

  changeset
  |> validate_format(field, ~r/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/,
    message: "must be a valid website URL")
  |> validate_required(field, required: required)
  |> validate_length(field, max: 255)
end
end
