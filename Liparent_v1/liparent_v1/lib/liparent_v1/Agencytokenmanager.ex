defmodule LiparentV1.Agencytokenmanager do
  import Ecto.Query
  require Logger
  alias LiparentV1.Repo
  alias LiparentV1.Schemas.Agencytokenschema


  def generate_token(employee) do
    claims = %{
      "sub" => employee.id,
      "email" => employee.email,
      "role" =>employee.role,
      "agencyid" => employee.agencyid
    }

    case LiparentV1.Agencyemployeetoken.generate_and_sign(claims) do
      {:ok, token, full_claims} ->
      case db_token_store(token, full_claims, employee.id) do
        {:ok, tokenstored} -> {:ok, tokenstored}
        {:error, reason} ->
          Logger.error("there was an issue storing the token :#{reason}")
          {:dbtokenstoreerror, "server error"}
      end

      {:error, reason} ->
        Logger.error("could not generate and sign token #{reason}")
        {:tokenerror, "server error"}
    end
  end
  # this is creating a token for agency employee
  defp db_token_store(token, claims, userid) do
    expires_at = case DateTime.from_unix(claims["exp"]) do
      {:ok, time} -> time
      _ -> nil
    end
    case Agencytokenschema.changeset(%Agencytokenschema{},%{
      token: token,
      userid: userid,
      agencyid: claims["agencyid"],
      jti: claims["jti"], #this is the index for tokens
      expires_at: expires_at
    })
    |>Repo.insert() do
      {:ok, tokenstore} -> {:ok, tokenstore}
      {:error, reason} ->
        Logger.error("could not store the token :#{reason}")
        {:error, "please try again"}
    end
  end

  def verifytoken(token) do
    case LiparentV1.Agencyemployeetoken.verify_and_validate(token) do
      {:ok, claims} ->
        case Repo.get_by(Agencytokenschema,jti: claims["jti"], revoked: false) do
          nil -> {:error, :token_revoked}
          token_record ->
            if DateTime.compare(token_record.expires_at, DateTime.utc_now()) == :gt do
              {:ok, claims}
            else
              {:error,:session_expired}
            end
        # {:error,reason}->
        #   Logger.error("there was an issue getting users token from the database")
        #   {:error, reason}
        end
      {:error, reason} ->
        Logger.error("there was an issue in verifying and validating token #{reason}")
        {:error,reason}
    end
  end
  def revoke_token(token) do
    case LiparentV1.Agencyemployeetoken.verify_and_validate(token) do
        {:ok, claims} ->
          case Repo.get_by(Agencytokenschema,jti: claims["jti"]) do
          nil ->
            {:error, :notfound}
          token_record ->
          token_record
          |>Agencytokenschema.changeset(%{revoked: true})
          |>Repo.update()
          Logger.info("successfully revoked a token #{token}")
          end
        {:error, reason} ->
          Logger.error("there was an issue in revoking #{token}: Reason#{reason}")
          {:error, reason}
    end
  end
  @spec cleanup_expired_tokens() :: {:ok, any()}
  def cleanup_expired_tokens do
    {deleted_count, _} = Repo.delete_all(
      from t in Agencytokenschema,
      where: t.expires_at < ^DateTime.utc_now()
    )
    {:ok, deleted_count}
  end
end
