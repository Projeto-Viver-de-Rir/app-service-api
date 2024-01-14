defmodule ViverderirWeb.EventsController do
  use ViverderirWeb, :controller

  alias ViverderirWeb.Views.Request.EventRequestView
  alias ViverderirWeb.Views.Response.EventResponseView
  alias ViverDeRir.Events

  require Logger

  def index(conn, _params) do
    Events.list_events(%{})
    |> case do
      {:ok, response} ->
        conn
        |> put_view(EventResponseView)
        |> render("index.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def detail(conn, %{"id" => id}) do
    Events.get_event(id)
    |> case do
      {:ok, response} ->
        conn
        |> put_view(EventResponseView)
        |> render("detail.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def create(conn, _params) do
    Logger.info("'Create' requested for events controller.")
    logged_user_id = Integer.to_string(get_session(conn, :account_id))

    Map.get(conn, :body_params)
    |> EventRequestView.to_domain_from_create_request()
    |> case do
      {:ok, domain} ->
        domain
        |> Events.create_event(logged_user_id)
        |> case do
          {:ok, response} ->
            conn
            |> put_view(EventResponseView)
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
    Logger.info("'Update' requested for events controller.")
    logged_user_id = Integer.to_string(get_session(conn, :account_id))

    Map.get(conn, :body_params)
    |> EventRequestView.to_domain_from_update_request(id)
    |> case do
      {:ok, domain} ->
        domain
        |> Events.update_event(logged_user_id)
        |> case do
          {:ok, response} ->
            conn
            |> put_view(EventResponseView)
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

    # {_status, item} = Events.update_event(%{id: id})

    conn
    |> send_resp(501, "Not Implemented yet. ID: #{id}")
  end

  def delete(conn, %{"id" => id}) do
    Logger.info("'Delete' requested for events controller.")
    logged_user_id = Integer.to_string(get_session(conn, :account_id))

    Events.delete_event(id, logged_user_id)

    conn
    |> send_resp(204, "")
  end
end
