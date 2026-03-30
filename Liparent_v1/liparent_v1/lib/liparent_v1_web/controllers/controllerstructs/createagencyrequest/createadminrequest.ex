defmodule LiparentV1Web.Controllerstructs.Createagencyrequest.Createadminrequest do
alias LiparentV1.Validation
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
  field :fullname, :string
  field :nationalid, :string
  field :earbregistration, :string
  field :iskmembership, :string
  field :krapin, :string
  field :practisingcertno, :string
  field :certexpirydate, :string
  end
  def principal_agent_changeset(basicinfo, params) do
  basicinfo
  |> cast(params, [
    :fullname,
    :nationalid,
    :earbregistration,
    :iskmembership,
    :krapin,
    :practisingcertno,
    :certexpirydate
  ])
  |> validate_required([:fullname, :nationalid])
  |> Validation.validate_string_name(:fullname)
  # Add the new validations
  |> validate_nationalid(:nationalid)
  |> validate_earbregistration(:earbregistration)
  |> validate_iskmembership(:iskmembership)
  |> validate_krapin(:krapin)
  |> validate_practisingcert(:practisingcertno)
  |> validate_certexpirydate(:certexpirydate)
end
  defp validate_nationalid(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    value = String.trim(value)

    cond do
      # Kenyan National ID is 8 digits (new format) or 7-8 digits (old format)
      # Some Kenyans may have 7-digit IDs from earlier years
      not String.match?(value, ~r/^\d{7,8}$/) ->
        [{field, "should be a valid Kenyan National ID (7-8 digits)"}]

      # Check if it matches the ID pattern (first digit cannot be 0)
      String.starts_with?(value, "0") ->
        [{field, "National ID cannot start with 0"}]

      # Optional: Check against known valid ID ranges
      # First digit should be 1-9 for valid Kenyan IDs
      not String.match?(value, ~r/^[1-9]\d{6,7}$/) ->
        [{field, "invalid National ID format"}]

      true ->
        []
    end
  end)
end

defp validate_earbregistration(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    value = String.trim(String.upcase(value))
    current_year = Date.utc_today().year

    cond do
      # EARB registration format: EA/XXX/XXXX or EA/XXX/YYYY
      # Estate Agents Registration Board format
      value == "" ->
        []

      not String.match?(value, ~r/^EA\/\d{3}\/\d{4}$/i) ->
        [{field, "should be in format EA/XXX/YYYY (e.g., EA/123/2024)"}]

      true ->
        [_prefix, _number, year] = String.split(value, "/")
        year_num = String.to_integer(year)

        cond do
          year_num < 2000 or year_num > current_year + 1 ->
            [{field, "invalid registration year"}]
          true ->
            []
        end
    end
  end)
end

defp validate_iskmembership(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    value = String.trim(String.upcase(value))

    cond do
      # ISK (Institution of Surveyors of Kenya) membership format
      value == "" ->
        []

      # Full member: M/XXX/YYYY, Associate: A/XXX/YYYY, Graduate: G/XXX/YYYY
      not String.match?(value, ~r/^[MAGF]\/(\d{4,6})\/\d{4}$/i) ->
        [{field, "should be in format [M/A/G/F]/XXXXX/YYYY (e.g., M/12345/2024)"}]

      [type, number, year] = String.split(value, "/")
      year_num = String.to_integer(year)
      # current_year = System.os_time(:second) |> DateTime.from_unix!() |> DateTime.to_date() |> Date.year_of_era()
      current_year = DateTime.utc_now().year

      cond do
        year_num < 2000 or year_num > current_year + 1 ->
          [{field, "invalid membership year"}]

        type not in ["M", "A", "G", "F"] ->
          [{field, "invalid membership type (M=Full, A=Associate, G=Graduate, F=Fellow)"}]

        String.to_integer(number) < 1 ->
          [{field, "invalid membership number"}]

        true ->
          []
      end

      true ->
        []
    end
  end)
end

defp validate_krapin(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    value = String.trim(String.upcase(value))

    cond do
      # KRA PIN format: A123456789B or A123456789Z
      # Valid formats:
      # - Individual: A followed by 9 digits then letter (usually A-Z)
      # - Company: P followed by 9 digits then letter
      # - Government: G followed by 9 digits then letter
      value == "" ->
        []

      not String.match?(value, ~r/^[APG]\d{9}[A-Z]$/) ->
        [{field, "should be a valid KRA PIN (e.g., A123456789B)"}]

      # Validate the checksum/control character
      # The last character is a check digit (simplified validation)
      # In production, you'd want to implement the actual KRA PIN validation algorithm
      prefix = String.at(value, 0)
      digits = String.slice(value, 1, 9)
      check_char = String.at(value, -1)

      cond do
        prefix not in ["A", "P", "G"] ->
          [{field, "invalid PIN prefix (should be A, P, or G)"}]

        not String.match?(digits, ~r/^\d{9}$/) ->
          [{field, "PIN should have 9 digits after prefix"}]

        # Simplified checksum validation (optional)
        # The actual KRA algorithm is more complex
        check_char not in ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
                           "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"] ->
          [{field, "invalid PIN check character"}]

        true ->
          []
      end

      true ->
        []
    end
  end)
end

defp validate_practisingcert(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    value = String.trim(String.upcase(value))

    cond do
      # Practising Certificate format: PC/XXX/YYYY
      # This is issued by EARB to registered agents
      value == "" ->
        []

      not String.match?(value, ~r/^PC\/\d{3,6}\/\d{4}$/i) ->
        [{field, "should be in format PC/XXXXX/YYYY (e.g., PC/12345/2024)"}]

      [_prefix, number, year] = String.split(value, "/")
      year_num = String.to_integer(year)
      # current_year = System.os_time(:second) |> DateTime.from_unix!() |> DateTime.to_date() |> Date.year_of_era()
      current_year = DateTime.utc_now().year

      cond do
        year_num < current_year - 1 ->
          [{field, "practising certificate appears expired (year: #{year})"}]

        year_num > current_year + 1 ->
          [{field, "invalid certificate year"}]

        String.to_integer(number) < 1 ->
          [{field, "invalid certificate number"}]

        true ->
          []
      end

      true ->
        []
    end
  end)
end

defp validate_certexpirydate(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    cond do
      # Ensure certificate expiry date is in the future
      is_nil(value) ->
        []

      not is_struct(value, Date) ->
        [{field, "must be a valid date"}]

      Date.compare(value, Date.utc_today()) == :lt ->
        [{field, "certificate has expired"}]

      true ->
        []
    end
  end)
end
end
