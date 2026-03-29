defmodule LiparentV1Web.Authcontroller do
  use LiparentV1Web, :controller
  use Joken.Config
  require Logger
  alias LiparentV1.Agencytokenmanager
  alias LiparentV1.Agencyemployeeaccount
# thsi is the login for agencies
  def agency_login(conn, %{"email"=>email, "password" => password}) do
    case Agencyemployeeaccount.authenticate_agency_employee(email,password) do
      {:ok, employee} ->
        {:ok,token} = Agencytokenmanager.generate_token(employee)
        conn
        |>put_status(:ok)
        |>json(%{
          success: true,
          data: %{
            token: token,
            fullname: employee.fullname
            # at this point is where we inject the rest of the data to send to the homescreen of the employee
          }
        })
      {:error, reason} ->
        Logger.info("invalid email or password: #{reason}")
        conn
        |>put_status(:unauthorized)
        |>json(%{
          success: false,
          error: "invalid email or password"
        })
    end
  end
end
