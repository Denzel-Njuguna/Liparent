defmodule LiparentV1.Repo do
  use Ecto.Repo,
    otp_app: :liparent_v1,
    adapter: Ecto.Adapters.Postgres
end
