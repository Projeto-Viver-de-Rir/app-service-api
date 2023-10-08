defmodule ViverderirWeb.Views.Request.VolunteerRequestView do
  alias Domain.Volunteers

  require Logger

  @spec to_domain_from_create_request(nil | maybe_improper_list | map) ::
          {:error, :validation_failed} | {:ok, Domain.Volunteers.t()}
  def to_domain_from_create_request(params) do
    %{
      name: params["name"],
      nickname: params["nickname"],
      email: params["email"],
      phone: params["phone"],
      address: params["address"],
      city: params["city"],
      state: params["state"],
      zip: params["zip"],
      birth_date: params["birth_date"],
      identifier: params["identifier"],
      availability: params["availability"],
      comments: params["comments"],
      status: params["status"]
    }
    |> Volunteers.cast_domain()
  end

  @spec to_domain_from_update_request(nil | maybe_improper_list | map, any) ::
          {:error, :validation_failed} | {:ok, Domain.Volunteers.t()}
  def to_domain_from_update_request(params, id) do
    %{
      id: id,
      name: params["name"],
      nickname: params["nickname"],
      email: params["email"],
      phone: params["phone"],
      address: params["address"],
      city: params["city"],
      state: params["state"],
      zip: params["zip"],
      birth_date: params["birth_date"],
      identifier: params["identifier"],
      availability: params["availability"],
      comments: params["comments"],
      status: params["status"]
    }
    |> Volunteers.cast_domain()
  end
end
