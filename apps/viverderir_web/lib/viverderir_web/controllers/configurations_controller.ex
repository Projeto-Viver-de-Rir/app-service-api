defmodule ViverderirWeb.ConfigurationsController do
  use ViverderirWeb, :controller

  alias ViverderirWeb.Views.Request.ConfigurationRequestView
  alias ViverderirWeb.Views.Response.ConfigurationResponseView
  alias ViverDeRir.Configurations

  require Logger

  def index(conn, _params) do
    Configurations.list_configurations(%{})
    |> case do
      {:ok, response} ->
        conn
        |> put_view(ConfigurationResponseView)
        |> render("index.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def detail(conn, %{"id" => id}) do
    Configurations.get_configuration(id)
    |> case do
      {:ok, response} ->
        conn
        |> put_view(ConfigurationResponseView)
        |> render("detail.json", response: response)

      {_, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "error")
    end
  end

  def create(conn, _params) do
    Logger.info("'Create' requested for configurations controller.")

    # TODO: extract from token or session
    logged_user_id = "1"

    Map.get(conn, :body_params)
    |> ConfigurationRequestView.to_domain_from_create_request()
    |> case do
      {:ok, domain} ->
        domain
        |> Configurations.create_configuration(logged_user_id)
        |> case do
          {:ok, response} ->
            conn
            |> put_view(ConfigurationResponseView)
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
    Logger.info("'Update' requested for configurations controller.")

    # TODO: extract from token or session
    logged_user_id = "1"

    Map.get(conn, :body_params)
    |> ConfigurationRequestView.to_domain_from_update_request(id)
    |> case do
      {:ok, domain} ->
        domain
        |> Configurations.update_configuration(logged_user_id)
        |> case do
          {:ok, response} ->
            conn
            |> put_view(ConfigurationResponseView)
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

    # {_status, item} = Configurations.update_configuration(%{id: id})

    conn
    |> send_resp(501, "Not Implemented yet. ID: #{id}")
  end

  def delete(conn, %{"id" => id}) do
    Logger.info("'Delete' requested for configurations controller.")

    # TODO: extract from token or session
    logged_user_id = "1"

    Configurations.delete_configuration(id, logged_user_id)

    conn
    |> send_resp(204, "")
  end
end
