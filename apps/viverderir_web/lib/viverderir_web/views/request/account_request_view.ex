defmodule ViverderirWeb.Views.Request.AccountsRequestView do
  alias Domain.Accounts

  require Logger

  @spec to_domain_from_sign_up(nil | maybe_improper_list | map) ::
          {:error, :validation_failed} | {:ok, Domain.Accounts.t()}
  def to_domain_from_sign_up(params) do
    %{
      id: nil,
      name: params["name"],
      email: params["email"],
      email_confirmed: false,
      password_hash: params["password"],
      access_failed_count: 0,
      photo_url: nil
    }
    |> Accounts.cast_domain()
  end
end
