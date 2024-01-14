defmodule ViverderirWeb.AccountsController do
  use ViverderirWeb, :controller

  require Logger
  alias ViverderirWeb.Auth.ErrorResponse
  alias ViverderirWeb.Auth.Guardian
  alias ViverderirWeb.Views.Request.AccountsRequestView
  alias ViverderirWeb.Views.Response.AccountsResponseView
  alias ViverDeRir.Accounts

  def get_me(conn, _params) do
    account_id = get_session(conn, :account_id)

    Accounts.get_account(account_id)
    |> case do
      {:ok, response} ->
        conn
        |> put_view(AccountsResponseView)
        |> render("get_me.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def sign_in(conn, _params) do
    data = Map.get(conn, :body_params)

    case Guardian.authenticate(data["email"], data["password"]) do
      {:ok, account, token} ->
        conn
        |> put_session(:account_id, account.id)
        |> put_status(200)
        |> put_view(AccountsResponseView)
        |> render("account.json", response: token)
      {:error, _} ->
        raise ErrorResponse.Unauthorized, message: "Email or password invalid."
      end
  end

  def sign_up(conn, _params) do
    Map.get(conn, :body_params)
    |> AccountsRequestView.to_domain_from_sign_up()
    |> case do
      {:ok, domain} ->
        domain
        |> Accounts.create_account("self")
        |> case do
          {:ok, _response} ->
            conn
            |> send_resp(201, "")

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

  def sign_out(conn, _params) do
    item = ~s({"token": ""})

    conn
    |> put_session(:account_id, nil)
    |> send_resp(200, item)
  end

  def delete(conn, _params) do
    item = ~s({"token": ""})

    conn
    |> send_resp(204, item)
  end
end
