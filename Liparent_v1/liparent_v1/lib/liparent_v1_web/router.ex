defmodule LiparentV1Web.Router do
  use LiparentV1Web, :router
  import Plug.Conn
  use Plug.ErrorHandler

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: [
        "http://localhost:5500"
    ]
  end
  pipeline :auth do
    plug :verify_token
    plug :ensure_authenticated
  end
  def verify_token(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
      {:ok, claims} <- LiparentV1.Agencytokenmanager.verifytoken(token) do
        conn
        |> assign(:current_user, claims)
    else
      _ -> conn
      end
  end
  def ensure_authenticated(conn, _opts) do
      if conn.assigns[:current_user] do
        conn
      else
        conn
        |>put_status(:unauthorized)
        |>json(%{error: "Authentication required"})
        |>halt()
      end
  end

  scope "/api", LiparentV1Web do
    pipe_through :api
    post "/signup", EmployeeController,:process_signup
    post "/login", EmployeeController,:process_login

  end
  scope "/api",LiparentV1Web do
    pipe_through [:api, :auth]
    # post "/home",HomeController,:load_home
  end

  # Enable LiveDashboard and Swoosh mailbox preview in developmet
  if Application.compile_env(:liparent_v1, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: LiparentV1Web.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
