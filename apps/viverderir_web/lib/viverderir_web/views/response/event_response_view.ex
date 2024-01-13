defmodule ViverderirWeb.Views.Response.EventResponseView do
  def render("index.json", %{
    response: response_index
      }) do
        %{
          events: Enum.map(response_index, fn(event) -> event_item(event) end),
          max: 100
        }
  end

  defp event_item(event) do
    %{
      id: event.id,
      name: event.name,
      description: event.description,
      address: event.address,
      city: event.city,
      meeting_point: event.meeting_point,
      date_time: event.date_time,
      occupancy: event.occupancy,
      status: event.status
    }
  end

  def render("detail.json", %{response: response_detail}) do
    event_item(response_detail)
  end

  def render("create.json", %{response: response_create}) do
    %{
      id: response_create.id,
      name: response_create.name,
      description: response_create.description,
      address: response_create.address,
      city: response_create.city,
      meeting_point: response_create.meeting_point,
      date_time: response_create.date_time,
      occupancy: response_create.occupancy,
      status: response_create.status
    }
  end

  def render("update.json", %{response: response_update}) do
    %{
      id: response_update.id,
      name: response_update.name,
      description: response_update.description,
      address: response_update.address,
      city: response_update.city,
      meeting_point: response_update.meeting_point,
      date_time: response_update.date_time,
      occupancy: response_update.occupancy,
      status: response_update.status
    }
  end
end
