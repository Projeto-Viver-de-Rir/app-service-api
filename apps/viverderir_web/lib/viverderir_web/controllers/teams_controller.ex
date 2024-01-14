defmodule ViverderirWeb.TeamsController do
  use ViverderirWeb, :controller

  alias ViverderirWeb.Views.Request.TeamRequestView
  alias ViverderirWeb.Views.Response.TeamResponseView
  alias ViverDeRir.Teams

  require Logger

  def index(conn, _params) do
    Teams.list_teams(%{})
    |> case do
      {:ok, response} ->
        conn
        |> put_view(TeamResponseView)
        |> render("index.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def detail(conn, %{"id" => id}) do
    Teams.get_team(id)
    |> case do
      {:ok, response} ->
        conn
        |> put_view(TeamResponseView)
        |> render("detail.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def create(conn, _params) do
    Logger.info("'Create' requested for teams controller.")
    logged_user_id = Integer.to_string(get_session(conn, :account_id))

    Map.get(conn, :body_params)
    |> TeamRequestView.to_domain_from_create_request()
    |> case do
      {:ok, domain} ->
        domain
        |> Teams.create_team(logged_user_id)
        |> case do
          {:ok, response} ->
            conn
            |> put_view(TeamResponseView)
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
    Logger.info("'Update' requested for teams controller.")
    logged_user_id = Integer.to_string(get_session(conn, :account_id))

    Map.get(conn, :body_params)
    |> TeamRequestView.to_domain_from_update_request(id)
    |> case do
      {:ok, domain} ->
        domain
        |> Teams.update_team(logged_user_id)
        |> case do
          {:ok, response} ->
            conn
            |> put_view(TeamResponseView)
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

    # {_status, item} = Teams.update_team(%{id: id})

    conn
    |> send_resp(501, "Not Implemented yet. ID: #{id}")
  end

  def delete(conn, %{"id" => id}) do
    Logger.info("'Delete' requested for teams controller.")
    logged_user_id = Integer.to_string(get_session(conn, :account_id))

    Teams.delete_team(id, logged_user_id)

    conn
    |> send_resp(204, "")
  end
end
