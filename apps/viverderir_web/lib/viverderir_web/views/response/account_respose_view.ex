defmodule ViverderirWeb.Views.Response.AccountsResponseView do

  def render("get_me.json", %{response: account}) do
    map_account = Map.from_struct(account)

    %{
      id: map_account.id,
      name: map_account.name,
      email: map_account.email,
    }
  end

  def render("account.json", %{response: item}) do
    %{
      token: item
    }
  end
end
