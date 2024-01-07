defmodule ViverderirWeb.Views.Response.AccountResponseView do
  def render("index.json", %{
    response: response_index
      }) do
        %{
          accounts: Enum.map(response_index, fn(account) -> account_item(account) end),
          max: 100
        }
  end

  defp account_item(account) do
    %{
      id: account.id,
      name: account.name,
      nickname: account.nickname
    }
  end

  def render("detail.json", %{response: response_detail}) do
    account_item(response_detail)
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
