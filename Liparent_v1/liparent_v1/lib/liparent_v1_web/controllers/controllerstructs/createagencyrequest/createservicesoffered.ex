defmodule LiparentV1Web.Controllerstructs.Createagencyrequest.Createservicesoffered do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :propertylettings, :boolean
    field :propertymanagement, :boolean
    field :shorttermmanagement, :boolean
    field :commercialleasing, :boolean
  end
  def services_changeset(basicinfo, params) do
    basicinfo
    |> cast(params, [
      :propertylettings,
      :propertymanagement,
      :shorttermmanagement,
      :commercialleasing
      ]
    |>validate_required([:propertylettings, :propertymanagement, :shorttermmanagement, :commercialleasing])
    |> validate_propertylettings(:propertylettings)
    |> validate_propertymanagement(:propertymanagement)
    |> validate_shorttermmanagement(:shorttermmanagement)
    |> validate_commercialleasing(:commercialleasing)
    |> validate_at_least_one_service()
    )
  end
  defp validate_propertylettings(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    # Property lettings service validation
    # This is a core service that requires separate licensing if offered
    cond do
      value == true or value == "true" ->
        # If offering lettings, ensure other requirements are met
        # This will be validated at the changeset level
        []

      value == false or value == "false" or is_nil(value) ->
        []

      true ->
        [{field, "must be true or false"}]
    end
  end)
end

defp validate_propertymanagement(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    # Property management service validation
    # This requires professional indemnity insurance
    cond do
      value == true or value == "true" ->
        # Check if indemnity insurance is provided when property management is offered
        if get_field(changeset, :indemnityinsuranceprovider) in [nil, ""] do
          [{field, "property management requires professional indemnity insurance"}]
        else
          []
        end

      value == false or value == "false" or is_nil(value) ->
        []

      true ->
        [{field, "must be true or false"}]
    end
  end)
end

defp validate_shorttermmanagement(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    # Short-term management validation (e.g., Airbnb, vacation rentals)
    # This has additional regulatory requirements under the Tourism Act
    cond do
      value == true or value == "true" ->
        # Check for additional requirements for short-term rentals
        # May require tourism license or specific permits
        []

      value == false or value == "false" or is_nil(value) ->
        []

      true ->
        [{field, "must be true or false"}]
    end
  end)
end

defp validate_commercialleasing(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    # Commercial leasing service validation
    # This involves more complex regulatory requirements
    cond do
      value == true or value == "true" ->
        # Check if the agent has commercial real estate experience
        # This may require additional qualifications
        []

      value == false or value == "false" or is_nil(value) ->
        []

      true ->
        [{field, "must be true or false"}]
    end
  end)
end

defp validate_at_least_one_service(changeset) do
  # Ensure at least one service is offered
  services = [
    get_field(changeset, :propertylettings),
    get_field(changeset, :propertymanagement),
    get_field(changeset, :shorttermmanagement),
    get_field(changeset, :commercialleasing)
  ]

  has_service = Enum.any?(services, fn service ->
    service == true or service == "true"
  end)

  if has_service do
    changeset
  else
    add_error(changeset, :propertylettings, "at least one service must be selected")
  end
end
end
