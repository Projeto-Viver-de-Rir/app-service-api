defmodule ViverderirWeb.Views.Request.UserRequestView do
  alias Domain.Accounts

  require Logger

  @spec to_domain_from_create_request(nil | maybe_improper_list | map) ::
          {:error, :validation_failed} | {:ok, Domain.Accounts.t()}
  def to_domain_from_create_request(params) do
    %{
      id: nil,
      name: params["name"],
      email: params["email"],
      email_confirmed: params["email_confirmed"],
      password_hash: params["password_hash"],
      access_failed_count: params["access_failed_count"],
      photo_url: params["photo_url"]
    }
    |> Accounts.cast_domain()
  end

  @spec to_domain_from_update_request(nil | maybe_improper_list | map, any) ::
          {:error, :validation_failed} | {:ok, Domain.Accounts.t()}
  def to_domain_from_update_request(params, id) do
    %{
      id: id,
      name: params["name"],
      email: params["email"],
      email_confirmed: params["email_confirmed"],
      password_hash: params["password_hash"],
      access_failed_count: params["access_failed_count"],
      photo_url: params["photo_url"]
    }
    |> Accounts.cast_domain()
  end
end
