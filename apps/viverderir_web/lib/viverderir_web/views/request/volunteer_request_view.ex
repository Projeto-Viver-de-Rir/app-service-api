defmodule ViverderirWeb.Views.Request.VolunteerRequestView do
  alias Database.Domain.Volunteers

  require Logger

  @spec to_domain_from_create_request(nil | maybe_improper_list | map, integer | nil) ::
          Ecto.Changeset.t()
  def to_domain_from_create_request(params, logged_user_id) do
    %Volunteers{
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
    |> Volunteers.create(logged_user_id)
  end

  @spec to_domain_from_update_request(
          nil | maybe_improper_list | map,
          integer | nil,
          integer | nil
        ) :: map()
  def to_domain_from_update_request(params, id, logged_user_id) do
    %Volunteers{
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
    |> Volunteers.update(logged_user_id)
  end
end
