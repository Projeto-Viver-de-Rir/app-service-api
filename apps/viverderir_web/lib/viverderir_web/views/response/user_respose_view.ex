defmodule ViverderirWeb.Views.Response.UserResponseView do
  def render("index.json", %{
    response: response_index
      }) do
        %{
          users: Enum.map(response_index, fn(user) -> user_item(user) end),
          max: 100
        }
  end

  defp user_item(user) do
    %{
      id: user.id,
      name: user.name,
      nickname: user.nickname
    }
  end

  def render("detail.json", %{response: response_detail}) do
    user_item(response_detail)
  end

  def render("create.json", %{response: response_create}) do
    %{
      id: response_create.id,
      name: response_create.name,
      email: response_create.email
    }
  end

  def render("update.json", %{response: response_update}) do
    %{
      id: response_update.id,
      name: response_update.name,
      email: response_update.email
    }
  end
end
