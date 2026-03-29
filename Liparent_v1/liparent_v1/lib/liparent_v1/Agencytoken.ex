defmodule LiparentV1.Agencyemployeetoken do
  use Joken.Config

  def token_config() do
    default_claims()
    |>add_claim("iss",fn -> "apex" end, &(&1 == "apex"))
    |>add_claim("aud", fn  -> "apex_agencies" end, &(&1 == "apex_agencies")) #this claim is to seperate agencies from tenants and landlords
  end
end
# here we have set the claims for agency tokens incase we want to chane them
