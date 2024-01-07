defmodule ViverderirWeb.Views.Request.EventRequestView do
  alias Domain.Events

  require Logger

  @spec to_domain_from_create_request(nil | maybe_improper_list | map) ::
          {:error, :validation_failed} | {:ok, Domain.Events.t()}
  def to_domain_from_create_request(params) do
    %{
      id: nil,
      name: params["name"],
      description: params["description"],
      address: params["address"],
      city: params["city"],
      meeting_point: params["meeting_point"],
      date_time: params["date_time"],
      occupancy: params["occupancy"],
      status: params["status"]
    }
    |> Events.cast_domain()
  end

  @spec to_domain_from_update_request(nil | maybe_improper_list | map, any) ::
          {:error, :validation_failed} | {:ok, Domain.Events.t()}
  def to_domain_from_update_request(params, id) do
    %{
      id: id,
      name: params["name"],
      description: params["description"],
      address: params["address"],
      city: params["city"],
      meeting_point: params["meeting_point"],
      date_time: params["date_time"],
      occupancy: params["occupancy"],
      status: params["status"]
    }
    |> Events.cast_domain()
  end
end
