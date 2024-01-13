defmodule ViverderirWeb.Views.Response.TeamResponseView do
  def render("index.json", %{
    response: response_index
      }) do
        %{
          teams: Enum.map(response_index, fn(team) -> team_item(team) end),
          max: 100
        }
  end

  defp team_item(team) do
    %{
      id: team.id,
      name: team.name,
      description: team.description
    }
  end

  def render("detail.json", %{response: response_detail}) do
    team_item(response_detail)
  end

  def render("create.json", %{response: response_create}) do
    %{
      id: response_create.id,
      name: response_create.name,
      description: response_create.description
    }
  end

  def render("update.json", %{response: response_update}) do
    %{
      id: response_update.id,
      name: response_update.name,
      description: response_update.description
    }
  end
end
