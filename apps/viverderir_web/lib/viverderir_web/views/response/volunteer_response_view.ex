defmodule ViverderirWeb.Views.Response.VolunteerResponseView do
  def render("detail.json", %{response: response_detail}) do
    %{
      id: response_detail.id,
      name: response_detail.name,
      nickname: response_detail.nickname
    }
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
