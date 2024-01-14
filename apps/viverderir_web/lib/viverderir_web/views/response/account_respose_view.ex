defmodule ViverderirWeb.Views.Response.AccountsResponseView do

  def render("account.json", %{response: item}) do
    %{
      token: item
    }
  end
end
