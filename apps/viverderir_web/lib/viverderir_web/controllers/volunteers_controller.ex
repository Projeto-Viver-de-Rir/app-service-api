defmodule ViverderirWeb.VolunteersController do
  use ViverderirWeb, :controller

  alias ViverderirWeb.Views.Request.VolunteerRequestView
  alias ViverderirWeb.Views.Response.VolunteerResponseView
  alias ViverDeRir.Volunteers

  require Logger

  def index(conn, _params) do
    Volunteers.list_volunteers(%{})
    |> case do
      {:ok, response} ->
        conn
        |> put_view(VolunteerResponseView)
        |> render("index.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def detail(conn, %{"id" => id}) do
    Volunteers.get_volunteer(id)
    |> case do
      {:ok, response} ->
        conn
        |> put_view(VolunteerResponseView)
        |> render("detail.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def create(conn, _params) do
    Logger.info("'Create' requested for volunteers controller.")
    logged_user_id = Integer.to_string(get_session(conn, :account_id))

    Map.get(conn, :body_params)
    |> VolunteerRequestView.to_domain_from_create_request()
    |> case do
      {:ok, domain} ->
        domain
        |> Volunteers.create_volunteer(logged_user_id)
        |> case do
          {:ok, response} ->
            conn
            |> put_view(VolunteerResponseView)
            |> render("create.json", response: response)

          {_, _} ->
            conn
            |> put_resp_content_type("application/json")
            |> send_resp(500, "error")
        end

      {:error, _validation_errors} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, "error")
    end
  end

  def update(conn, %{"id" => id}) do
    Logger.info("'Update' requested for volunteers controller.")
    logged_user_id = Integer.to_string(get_session(conn, :account_id))

    Map.get(conn, :body_params)
    |> VolunteerRequestView.to_domain_from_update_request(id)
    |> case do
      {:ok, domain} ->
        domain
        |> Volunteers.update_volunteer(logged_user_id)
        |> case do
          {:ok, response} ->
            conn
            |> put_view(VolunteerResponseView)
            |> render("update.json", response: response)

          {_, _} ->
            conn
            |> put_resp_content_type("application/json")
            |> send_resp(500, "error")
        end

      {:error, _validation_errors} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, "error")
    end
  end

  def patch(conn, %{"id" => id}) do
    Map.get(conn, :body_params)

    # {_status, item} = Volunteers.update_volunteer(%{id: id})

    conn
    |> send_resp(501, "Not Implemented yet. ID: #{id}")
  end

  def delete(conn, %{"id" => id}) do
    Logger.info("'Delete' requested for volunteers controller.")
    logged_user_id = Integer.to_string(get_session(conn, :account_id))

    Volunteers.delete_volunteer(id, logged_user_id)

    conn
    |> send_resp(204, "")
  end
end
