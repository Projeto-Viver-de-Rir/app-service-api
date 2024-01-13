defmodule ViverderirWeb.Views.Request.ConfigurationRequestView do
  alias Domain.Configurations

  require Logger

  @spec to_domain_from_create_request(nil | maybe_improper_list | map) ::
          {:error, :validation_failed} | {:ok, Domain.Configurations.t()}
  def to_domain_from_create_request(params) do
    %{
      id: nil,
      name: params["name"],
      description: params["description"],
      properties: params["properties"]
    }
    |> Configurations.cast_domain()
  end

  @spec to_domain_from_update_request(nil | maybe_improper_list | map, any) ::
          {:error, :validation_failed} | {:ok, Domain.Configurations.t()}
  def to_domain_from_update_request(params, id) do
    %{
      id: id,
      name: params["name"],
      description: params["description"],
      properties: params["properties"]
    }
    |> Configurations.cast_domain()
  end
end
