defmodule ViverderirWeb.Views.Response.VolunteerResponseView do
  def render("index.json", %{
    response: response_index
      }) do
        %{
          volunteers: Enum.map(response_index, fn(volunteer) -> volunteer_item(volunteer) end),
          max: 100
        }
  end

  defp volunteer_item(volunteer) do
    %{
      id: volunteer.id,
      name: volunteer.name,
      nickname: volunteer.nickname
    }
  end

  def render("detail.json", %{response: response_detail}) do
    volunteer_item(response_detail)
  end

  def render("create.json", %{response: response_create}) do
    %{
      id: response_create.id,
      name: response_create.name,
      nickname: response_create.nickname
    }
  end

  def render("update.json", %{response: response_update}) do
    %{
      id: response_update.id,
      name: response_update.name,
      nickname: response_update.nickname
    }
  end
end
