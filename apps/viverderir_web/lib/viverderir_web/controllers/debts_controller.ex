defmodule ViverderirWeb.DebtsController do
  use ViverderirWeb, :controller

  alias ViverderirWeb.Views.Request.DebtRequestView
  alias ViverderirWeb.Views.Response.DebtResponseView
  alias ViverDeRir.Debts

  require Logger

  def index(conn, _params) do
    Debts.list_debts(%{})
    |> case do
      {:ok, response} ->
        conn
        |> put_view(DebtResponseView)
        |> render("index.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def detail(conn, %{"id" => id}) do
    Debts.get_debt(id)
    |> case do
      {:ok, response} ->
        conn
        |> put_view(DebtResponseView)
        |> render("detail.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def create(conn, _params) do
    Logger.info("'Create' requested for debts controller.")

    # TODO: extract from token or session
    logged_user_id = "1"

    Map.get(conn, :body_params)
    |> DebtRequestView.to_domain_from_create_request()
    |> case do
      {:ok, domain} ->
        domain
        |> Debts.create_debt(logged_user_id)
        |> case do
          {:ok, response} ->
            conn
            |> put_view(DebtResponseView)
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
    Logger.info("'Update' requested for debts controller.")

    # TODO: extract from token or session
    logged_user_id = "1"

    Map.get(conn, :body_params)
    |> DebtRequestView.to_domain_from_update_request(id)
    |> case do
      {:ok, domain} ->
        domain
        |> Debts.update_debt(logged_user_id)
        |> case do
          {:ok, response} ->
            conn
            |> put_view(DebtResponseView)
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

    # {_status, item} = Debts.update_debt(%{id: id})

    conn
    |> send_resp(501, "Not Implemented yet. ID: #{id}")
  end

  def delete(conn, %{"id" => id}) do
    Logger.info("'Delete' requested for debts controller.")

    # TODO: extract from token or session
    logged_user_id = "1"

    Debts.delete_debt(id, logged_user_id)

    conn
    |> send_resp(204, "")
  end
end
