defmodule ViverderirWeb.Views.Response.ConfigurationResponseView do
  def render("index.json", %{
    response: response_index
      }) do
        %{
          configurations: Enum.map(response_index, fn(configuration) -> configuration_item(configuration) end),
          max: 100
        }
  end

  defp configuration_item(configuration) do
    %{
      id: configuration.id,
      name: configuration.name,
      properties: configuration.properties
    }
  end

  def render("detail.json", %{response: response_detail}) do
    configuration_item(response_detail)
  end

  def render("create.json", %{response: response_create}) do
    %{
      id: response_create.id,
      name: response_create.name,
      properties: response_create.properties
    }
  end

  def render("update.json", %{response: response_update}) do
    %{
      id: response_update.id,
      name: response_update.name,
      properties: response_update.properties
    }
  end
end
