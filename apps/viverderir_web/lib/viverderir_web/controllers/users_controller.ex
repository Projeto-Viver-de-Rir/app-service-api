defmodule ViverderirWeb.UsersController do
  use ViverderirWeb, :controller

  alias ViverderirWeb.Views.Request.UserRequestView
  alias ViverderirWeb.Views.Response.UserResponseView
  alias ViverDeRir.Accounts

  require Logger

  def index(conn, _params) do
    Accounts.list_accounts(%{})
    |> case do
      {:ok, response} ->
        conn
        |> put_view(UserResponseView)
        |> render("index.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def detail(conn, %{"id" => id}) do
    Accounts.get_account(id)
    |> case do
      {:ok, response} ->
        conn
        |> put_view(UserResponseView)
        |> render("detail.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def create(conn, _params) do
    Logger.info("'Create' requested for accounts controller.")
    logged_user_id = Integer.to_string(get_session(conn, :account_id))

    Map.get(conn, :body_params)
    |> UserRequestView.to_domain_from_create_request()
    |> case do
      {:ok, domain} ->
        domain
        |> Accounts.create_account(logged_user_id)
        |> case do
          {:ok, response} ->
            conn
            |> put_view(UserResponseView)
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
    Logger.info("'Update' requested for accounts controller.")
    logged_user_id = Integer.to_string(get_session(conn, :account_id))

    Map.get(conn, :body_params)
    |> UserRequestView.to_domain_from_update_request(id)
    |> case do
      {:ok, domain} ->
        domain
        |> Accounts.update_account(logged_user_id)
        |> case do
          {:ok, response} ->
            conn
            |> put_view(UserResponseView)
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

    # {_status, item} = Accounts.update_account(%{id: id})

    conn
    |> send_resp(501, "Not Implemented yet. ID: #{id}")
  end

  def delete(conn, %{"id" => id}) do
    Logger.info("'Delete' requested for accounts controller.")
    logged_user_id = Integer.to_string(get_session(conn, :account_id))

    Accounts.delete_account(id, logged_user_id)

    conn
    |> send_resp(204, "")
  end
end
