defmodule LiparentV1Web.Controllerstructs.Createagencyrequest.Createagencycompliancerequest do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
  field :earblicenceno, :string
  field :licenceexpirydate, :string
  field :incorporationno, :string
  field :singlebusinesspermitno, :string
  field :indemnityinsuranceprovider, :string
  field :policyexpirydate, :string
  field :trustaccountbank, :string
  field :trustaccountno, :string
  field :amlcompliance, :boolean
  end

def compliance_info_changeset(compliance_info, params) do
  compliance_info
  |> cast(params, [
    :earblicenceno,
    :licenceexpirydate,
    :incorporationno,
    :singlebusinesspermitno,
    :indemnityinsuranceprovider,
    :policyexpirydate,
    :trustaccountbank,
    :trustaccountno,
    :amlcompliance
  ])
  |>maybe_convert_aml_compliance()
  |> validate_required([
    :earblicenceno,
    :licenceexpirydate,
    :incorporationno,
    :singlebusinesspermitno,
    :indemnityinsuranceprovider,
    :policyexpirydate,
    :trustaccountbank,
    :trustaccountno,
    :amlcompliance
  ])
  |> validate_earblicence(:earblicenceno)
  |> validate_licenceexpirydate(:licenceexpirydate)
  |> validate_incorporationno(:incorporationno)
  |> validate_singlebusinesspermit(:singlebusinesspermitno)
  |> validate_indemnityinsurance(:indemnityinsuranceprovider)
  |> validate_policyexpirydate(:policyexpirydate)
  |> validate_trustaccountbank(:trustaccountbank)
  |> validate_trustaccountno(:trustaccountno)
  |> validate_amlcompliance(:amlcompliance)
end
defp maybe_convert_aml_compliance(changeset) do
  case fetch_change(changeset, :amlcompliance) do
    {:ok, value} when is_binary(value) ->
      boolean_value = case String.downcase(value) do
        "true" -> true
        "false" -> false
        _ -> value
      end
      put_change(changeset, :amlcompliance, boolean_value)

    _ ->
      changeset
  end
end
defp validate_earblicence(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    value = String.trim(String.upcase(value))

    cond do
      # EARB Licence format: EARB/XXX/YYYY or similar
      # This is the main licence issued to real estate firms
      value == "" ->
        []

      # Check for different valid EARB licence formats
      # Format 1: EARB/XXX/YYYY (common format)
      # Format 2: EA/XXX/YYYY (alternative format)
      not String.match?(value, ~r/^(EARB|EA)\/\d{3,6}\/\d{4}$/i) ->
        [{field, "should be in format EARB/XXXXX/YYYY or EA/XXXXX/YYYY (e.g., EARB/12345/2024)"}]

      [_prefix, number, year] = String.split(value, "/")
      year_num = String.to_integer(year)
      # current_year = System.os_time(:second) |> DateTime.from_unix!() |> DateTime.to_date() |> Date.year_of_era()
      current_year = DateTime.utc_now().year

      cond do
        year_num < 2000 or year_num > current_year + 2 ->
          [{field, "invalid licence year"}]

        String.to_integer(number) < 1 ->
          [{field, "invalid licence number"}]

        true ->
          []
      end

      true ->
        []
    end
  end)
end

defp validate_licenceexpirydate(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    cond do
      is_nil(value) ->
        []

      not is_struct(value, Date) ->
        [{field, "must be a valid date"}]

      # Check if licence is already expired
      Date.compare(value, Date.utc_today()) == :lt ->
        [{field, "licence has expired"}]

      # Check if licence expiry is more than 5 years in the future (unrealistic)
      # max_future = Date.add(Date.utc_today(), 5 * 365)
      Date.compare(value, Date.add(Date.utc_today(), 5 * 365)) == :gt ->
        [{field, "licence expiry date cannot be more than 5 years in the future"}]

      true ->
        []
    end
  end)
end

defp validate_incorporationno(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    value = String.trim(String.upcase(value))

    cond do
      # Company incorporation number formats in Kenya:
      # - Limited company: C/XXXXX/YYYY or CPR/XXXXX/YYYY or PVT/XXXXX/YYYY
      # - Business name: BN/XXXXX/YYYY
      value == "" ->
        []

      not String.match?(value, ~r/^(C|CPR|PVT|BN)\/\d{4,8}\/\d{4}$/i) ->
        [{field, "should be in format [C/CPR/PVT/BN]/XXXXX/YYYY (e.g., C/123456/2020)"}]

      [type, number, year] = String.split(value, "/")
      year_num = String.to_integer(year)
      # current_year = System.os_time(:second) |> DateTime.from_unix!() |> DateTime.to_date() |> Date.year_of_era()
      current_year = DateTime.utc_now().year

      cond do
        year_num < 1950 or year_num > current_year + 1 ->
          [{field, "invalid incorporation year"}]

        type not in ["C", "CPR", "PVT", "BN"] ->
          [{field, "invalid incorporation type"}]

        String.to_integer(number) < 1 ->
          [{field, "invalid incorporation number"}]

        true ->
          []
      end

      true ->
        []
    end
  end)
end

defp validate_singlebusinesspermit(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    value = String.trim(String.upcase(value))

    cond do
      # Single Business Permit (County Government) format varies by county
      # Common formats: SBP/XXXXX/YYYY, COUNTY/XXXXX/YYYY, or just alphanumeric
      value == "" ->
        []

      # Check for county-specific formats
      not String.match?(value, ~r/^[A-Z0-9\/-]{5,30}$/i) ->
        [{field, "should be a valid Single Business Permit number"}]

      # Validate if it follows common format
      cond do
        String.match?(value, ~r/^(SBP|SB|COUNTY)\/\d{4,8}\/\d{4}$/i) ->
          # Extract and validate year if present
          parts = String.split(value, "/")
          if length(parts) >= 3 do
            year = List.last(parts)
            if String.match?(year, ~r/^\d{4}$/) do
              year_num = String.to_integer(year)
              current_year = DateTime.utc_now().year

              if year_num < current_year - 2 or year_num > current_year + 2 do
                [{field, "permit year appears invalid"}]
              else
                []
              end
            else
              []
            end
          else
            []
          end

        true ->
          # Allow custom permit formats from different counties
          if String.length(value) < 3 do
            [{field, "permit number too short"}]
          else
            []
          end
      end

      true ->
        []
    end
  end)
end

defp validate_indemnityinsurance(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    value = String.trim(value)

    cond do
      # Professional Indemnity Insurance provider validation
      value == "" ->
        []

      # Check if provider is a recognized insurer in Kenya
      # You can maintain a list of recognized providers
      recognized_providers = [
        "APA", "BRITAM", "CIC", "DIRECTLINE", "GA", "HERITAGE", "ICEA LION",
        "JUBILEE", "KENYA RE", "LIBERTY", "MADISON", "PACIS", "SANLAM",
        "TRIDENT", "UAP", "OLD MUTUAL", "ZURICH"
      ]

      # Check if the provider is recognized (case-insensitive)
      provider_normalized = value |> String.upcase() |> String.trim()

      recognized = Enum.any?(recognized_providers, fn provider ->
        String.contains?(provider_normalized, String.upcase(provider)) or
        String.contains?(String.upcase(provider), provider_normalized)
      end)

      cond do
        String.length(value) < 3 ->
          [{field, "insurance provider name must be at least 3 characters"}]

        not recognized ->
          # Warning only, not a hard validation
          # [{field, "please confirm insurance provider is recognized in Kenya"}]
          []

        true ->
          []
      end

      true ->
        []
    end
  end)
end

defp validate_policyexpirydate(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    cond do
      is_nil(value) ->
        []

      not is_struct(value, Date) ->
        [{field, "must be a valid date"}]

      Date.compare(value, Date.utc_today()) == :lt ->
        [{field, "insurance policy has expired"}]

      # Check if policy expiry is more than 3 years in the future
      # max_future = Date.add(Date.utc_today(), 3 * 365)
      Date.compare(value, Date.add(Date.utc_today(), 3 * 365)) == :gt ->
        [{field, "policy expiry date cannot be more than 3 years in the future"}]

      true ->
        []
    end
  end)
end

defp validate_trustaccountbank(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    value = String.trim(value)

    cond do
      # Trust account bank validation
      value == "" ->
        [{field, "trust account bank is required"}]

      # Recognized banks in Kenya (Central Bank of Kenya regulated)
      recognized_banks = [
        "ABSA", "BANK OF AFRICA", "BANK OF BARODA", "BANK OF INDIA",
        "BARCLAYS", "CITIBANK", "COOPERATIVE BANK", "CRDB", "DIAMOND TRUST BANK",
        "ECOBANK", "EQUITY", "FAMILY BANK", "FIRST COMMUNITY BANK", "GUARANTY TRUST BANK",
        "GULF AFRICAN BANK", "HABIB BANK", "I&M", "KCB", "MIDDLE EAST BANK",
        "MORAN BANK", "NATIONAL BANK", "NCBA", "PARAMOUNT BANK", "PRIME BANK",
        "SIDIAN BANK", "SPIRE BANK", "STANBIC", "STANDARD CHARTERED", "UNITED BANK LIMITED"
      ]

      bank_normalized = value |> String.upcase() |> String.trim()

      recognized = Enum.any?(recognized_banks, fn bank ->
        String.contains?(bank_normalized, String.upcase(bank)) or
        String.contains?(String.upcase(bank), bank_normalized)
      end)

      cond do
        String.length(value) < 3 ->
          [{field, "bank name must be at least 3 characters"}]

        not recognized ->
          [{field, "bank must be a CBK-regulated bank in Kenya"}]

        true ->
          []
      end

      true ->
        []
    end
  end)
end

defp validate_trustaccountno(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    value = String.trim(value)

    cond do
      # Trust account number validation
      # Kenyan bank account numbers are typically 10-16 digits
      value == "" ->
        [{field, "trust account number is required"}]

      not String.match?(value, ~r/^\d{10,16}$/) ->
        [{field, "should be a valid bank account number (10-16 digits)"}]

      # Check for obvious invalid patterns
      String.match?(value, ~r/^(\d)\1+$/) ->
        [{field, "invalid account number pattern"}]

      true ->
        []
    end
  end)
end

defp validate_amlcompliance(changeset, field) do
  validate_change(changeset, field, fn _, value ->
    # AML (Anti-Money Laundering) compliance validation
    cond do
      value == false ->
        [{field, "AML compliance must be confirmed to operate as a real estate agent in Kenya"}]

      true ->
        []
    end
  end)
end
end
