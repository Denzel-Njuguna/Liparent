defmodule LiparentV1Web.Agencycontroller do
  use LiparentV1Web, :controller
  alias LiparentV1.Schemas.Createagencyschemas.Principalagentdbschema
  alias LiparentV1.Schemas.Agencyemployeeschema
  alias LiparentV1.Repo
  alias Ecto.Multi
  alias LiparentV1.Schemas.Createagencyschemas.{Compliancedbschema, Basicinfodbschema,Principalagentdbschema,Createoperationsdbschema,Servicesdbschema}
  alias LiparentV1Web.Controllerstructs.Createagencyrequest.Createservicesoffered
  alias LiparentV1Web.Controllerstructs.Createagencyrequest.Createareasofoperation
  alias LiparentV1Web.Controllerstructs.Createagencyrequest.Createagencybasicinfo
  alias LiparentV1Web.Controllerstructs.Createagencyrequest.Createagencycompliancerequest
  alias LiparentV1Web.Controllerstructs.Createagencyrequest.Createadminrequest
  require Logger

  def process_create_agency(conn, params) do
    adminchangeset = Createadminrequest.principal_agent_changeset(%Createadminrequest{}, params)
    basicchangeset = Createagencybasicinfo.basic_info_changeset(%Createagencybasicinfo{}, params)
    compliancechangeset = Createagencycompliancerequest.compliance_info_changeset(%Createagencycompliancerequest{}, params)
    operationschangeset = Createareasofoperation.areas_changeset(%Createareasofoperation{}, params)
    serviceschangeset = Createservicesoffered.services_changeset(%Createservicesoffered{}, params)

    if all_valid?([adminchangeset, basicchangeset, compliancechangeset, operationschangeset, serviceschangeset]) do
      case {
        Ecto.Changeset.apply_action(basicchangeset, :validate),
        Ecto.Changeset.apply_action(adminchangeset, :validate),
        Ecto.Changeset.apply_action(compliancechangeset, :validate),
        Ecto.Changeset.apply_action(operationschangeset, :validate),
        Ecto.Changeset.apply_action(serviceschangeset, :validate)
      } do
        {{:ok, basic}, {:ok, admin}, {:ok, compliance}, {:ok, operations}, {:ok, services}} ->
          combineddata = %{
            basic: basic,
            admin: admin,
            compliance: compliance,
            operations: operations,
            services: services
          }
          create_agency_with_all_data(conn, combineddata)

        _ ->
          errors = %{
            basic: basicchangeset.errors,
            admin: adminchangeset.errors,
            compliance: compliancechangeset.errors,
            operations: operationschangeset.errors,
            services: serviceschangeset.errors
          }
          json(conn, %{success: false, errors: errors})
      end
    else
      errors = %{
        basic: basicchangeset.errors,
        admin: adminchangeset.errors,
        compliance: compliancechangeset.errors,
        operations: operationschangeset.errors,
        services: serviceschangeset.errors
      }
      json(conn, %{success: false, errors: errors})
    end
  end

  defp all_valid?(changesets) do
    Enum.all?(changesets, &(&1.valid?))
  end

  defp create_agency_with_all_data(conn, val_changesets) do
    result =
      Multi.new()

      # ─── step 1: insert agency ───────────────────────────────────────────
      |> Multi.insert(:agency,
    Basicinfodbschema.changeset(%Basicinfodbschema{}, Map.from_struct(val_changesets.basic))
      )

      # ─── step 2: insert employee (admin, createdby = nil for now) ────────
      |> Multi.insert(:employee, fn %{agency: agency} ->
        Agencyemployeeschema.registration_changeset(
          %Agencyemployeeschema{},
          %{
            fullname: val_changesets.admin.fullname,
            email: val_changesets.basic.businessemail,
            agencyid: agency.agencyid,
            phonenumber: val_changesets.basic.phonenumber,
            password: val_changesets.admin.password,
            role: :admin,
            createdby: nil  # will be updated in step 3
          }
        )
      end)

      # ─── step 3: update employee createdby = their own employeeid ────────
      |> Multi.update(:employee_self_ref, fn %{employee: employee} ->
        Ecto.Changeset.change(employee, %{createdby: employee.employeeid})
      end)

      # ─── step 4: insert principal agent ──────────────────────────────────
      |> Multi.insert(:principal_agent, fn %{employee_self_ref: employee} ->
        Principalagentdbschema.changeset(
          %Principalagentdbschema{},
          val_changesets.admin,
          employee.employeeid
        )
      end)

      # ─── step 5: insert compliance ───────────────────────────────────────
      |> Multi.insert(:compliance, fn %{agency: agency} ->
        Compliancedbschema.changeset(
          %Compliancedbschema{},
          val_changesets.compliance,
          agency.agencyid
        )
      end)

      # ─── step 6: insert areas of operation ───────────────────────────────
      |> Multi.insert(:areasofoperation, fn %{agency: agency} ->
        Createoperationsdbschema.changeset(
          %Createoperationsdbschema{},
          Map.from_struct(val_changesets.operations),
          agency.agencyid
        )
      end)

      # ─── step 7: insert services ─────────────────────────────────────────
      |> Multi.insert(:services, fn %{agency: agency} ->
        Servicesdbschema.changeset(
          %Servicesdbschema{},
          Map.from_struct(val_changesets.services),
          agency.agencyid
        )
      end)

      |> Repo.transaction()

    case result do
      {:ok, %{agency: agency, employee: employee, principal_agent: _principal_agent}} ->
        Logger.info("agency created successfully: #{agency.agencyid}, employee: #{employee.employeeid}")
        json(conn, %{
          success: true,
          message: "agency created successfully",
          agencyid: agency.agencyid
        })

      {:error, failed_step, failed_changeset, _changes_so_far} ->
        Logger.error("agency creation failed at step: #{failed_step}")
        json(conn, %{
          success: false,
          error: "failed at step: #{failed_step}",
          details: format_errors(failed_changeset)
        })
    end
  end

  # ─── helpers ─────────────────────────────────────────────────────────────

  defp format_errors(%Ecto.Changeset{} = Changeset) do
    Ecto.Changeset.traverse_errors(Changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  # if failed_step returns something other than a Changeset e.g. a string
  defp format_errors(other), do: inspect(other)
end
