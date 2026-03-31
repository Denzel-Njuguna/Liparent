defmodule LiparentV1Web.Controllerstructs.Createagencyrequest.Createareasofoperation do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
  field :countiestownsserved, :string
  field :residential, :boolean
  field :commercial, :boolean
  field :industrial, :boolean
  field :land, :boolean
  end

  def areas_changeset(basicinfo, params) do
  basicinfo
  |> cast(params, [
    :countiestownsserved,
    :residential,
    :commercial,
    :industrial,
    :land
  ])
  |>validate_required([:countiestownserved, :residential, :commercial, :land, :industrial])
  |> validate_countiestownsserved(:countiestownsserved)
  |> validate_residential(:residential)
  |> validate_commercial(:commercial)
  |> validate_industrial(:industrial)
  |> validate_land(:land)
  # |> validate_at_least_one_property_type()
  end
  defp validate_countiestownsserved(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    value = String.trim(value)

    cond do
      # Counties and towns served validation
      # Under Kenyan law, real estate agents must specify their operational areas
      value == "" ->
        [{field, "at least one county or town must be specified"}]

      true ->
        # Check if it's a valid Kenyan county or town
        # You can maintain a list of Kenyan counties
        kenyan_counties = [
          "MOMBASA", "KWALE", "KILIFI", "TANA RIVER", "LAMU", "TAITA TAVETA",
          "GARISSA", "WAJIR", "MANDERA", "MARSABIT", "ISIOLO", "MERU",
          "THARAKA NITHI", "EMBU", "KITUI", "MACHAKOS", "MAKUENI", "NYANDARUA",
          "NYERI", "KIRINYAGA", "MURANG'A", "KIAMBU", "TURKANA", "WEST POKOT",
          "SAMBURU", "TRANS NZOIA", "UASIN GISHU", "ELGEYO MARAKWET", "NANDI",
          "BARINGO", "LAIKIPIA", "NAKURU", "NAROK", "KAJIADO", "KERICHO",
          "BOMET", "KAKAMEGA", "VIHIGA", "BUNGOMA", "BUSIA", "SIAYA",
          "KISUMU", "HOMA BAY", "MIGORI", "KISII", "NYAMIRA", "NAIROBI"
        ]

        # Check if at least one valid Kenyan county or town is mentioned
        counties_served = String.split(value, ~r/[,;]\s*/)

        # Validate each county/town (optional - can be lenient)
        invalid_counties = Enum.filter(counties_served, fn county ->
          county_upper = String.upcase(String.trim(county))
          not (Enum.any?(kenyan_counties, fn kenyan_county ->
            String.contains?(county_upper, kenyan_county) or
            String.contains?(kenyan_county, county_upper)
          end) or String.length(county_upper) < 3)
        end)

        cond do
          length(counties_served) > 47 ->
            [{field, "cannot specify more than 47 counties (all counties in Kenya)"}]

          length(invalid_counties) > 0 and length(counties_served) > 0 ->
            # Warning only, not a hard validation since towns might be specified
            []

          true ->
            []
        end
    end
  end)
end

defp validate_residential(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    # Residential property operation validation
    cond do
      value == true or value == "true" ->
        # Residential operations require additional consumer protection measures
        # and clear tenancy agreements under the Landlord and Tenant Act
        []

      value == false or value == "false" or is_nil(value) ->
        []

      true ->
        [{field, "must be true or false"}]
    end
  end)
end

defp validate_commercial(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    # Commercial property operation validation
    # This requires understanding of business tenancies and commercial leases
    cond do
      value == true or value == "true" ->
        # Commercial operations have specific requirements under the Land Act
        # and require specialized knowledge
        []

      value == false or value == "false" or is_nil(value) ->
        []

      true ->
        [{field, "must be true or false"}]
    end
  end)
end

defp validate_industrial(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    # Industrial property operation validation
    # This involves environmental regulations and industrial zoning
    cond do
      value == true or value == "true" ->
        # Industrial operations require NEMA compliance and specific permits
        # Check if environmental impact considerations are addressed
        []

      value == false or value == "false" or is_nil(value) ->
        []

      true ->
        [{field, "must be true or false"}]
    end
  end)
end

defp validate_land(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    # Land transactions validation
    # Land dealings are highly regulated under the Land Registration Act
    cond do
      value == true or value == "true" ->
        # Check if the agent has land transaction authorization
        # This requires additional qualifications and possibly higher bond amounts
        # under the Estate Agents Act

        # Verify that the agent is registered for land dealings
        earb_registration = get_field(changeset, :earblicenceno)

        cond do
          earb_registration in [nil, ""] ->
            [{field, "land dealings require valid EARB registration"}]

          true ->
            []
        end

      value == false or value == "false" or is_nil(value) ->
        []

      true ->
        [{field, "must be true or false"}]
    end
  end)
end

defp validate_at_least_one_property_type(changeset) do
  # Ensure at least one property type is selected
  property_types = [
    get_field(changeset, :residential),
    get_field(changeset, :commercial),
    get_field(changeset, :industrial),
    get_field(changeset, :land)
  ]

  has_property_type = Enum.any?(property_types, fn property_type ->
    property_type == true or property_type == "true"
  end)

  if has_property_type do
    changeset
  else
    add_error(changeset, :residential, "at least one property type must be selected")
  end
end

# Helper function to convert boolean string to boolean
defp maybe_convert_boolean_fields(changeset, fields) do
  Enum.reduce(fields, changeset, fn field, acc ->
    case fetch_change(acc, field) do
      {:ok, value} when is_binary(value) ->
        boolean_value = case String.downcase(value) do
          "true" -> true
          "false" -> false
          "on" -> true
          "off" -> false
          _ -> value
        end
        put_change(acc, field, boolean_value)

      _ ->
        acc
    end
  end)
end
end
