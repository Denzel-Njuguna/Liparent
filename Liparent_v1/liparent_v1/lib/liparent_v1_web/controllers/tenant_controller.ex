defmodule LiparentV1Web.TenantController do
  alias Ecto.UUID
  # this is going to handle all logic that involves a tenant hitting my api from the router
  use LiparentV1Web, :controller
  alias LiparentV1Web.Controllerstructs.Createtenantrequest

# """
#   example struct for creating a tenant(data required)
#   {
#     field :tenantid, Ecto.UUID
#     field :fullname, :string
#     field :buidingid, Ecto.UUID
#     field :buildingname, :string
#     field :houseno, :string
#     field :phonenumber, :string
#     field :password, :string
#   }
# """
  def create_tenant(conn, %{"fullname"=>fullname, "buildingid"=>buildingid, "buildingname"=>buildingname, "houseno"=>houseno, "phonenumber"=>phonenumber, "password"=>password}) do
    tenantid = UUID.generate()
    changeset = Createtenantrequest.changeset(%{tenantid: tenantid,fullname: fullname,buildingid: buildingid,buildingname: buildingname,houseno: houseno,phonenumber: phonenumber,password: password})
    case Ecto.Changeset.apply_action(changeset, :validate) do
      {:ok,valid_request} -> json(conn, valid_request)
      {:error,failed_request} ->
        json(conn,%{status: "error", errors: failed_request.errors})
    end
  end

end
