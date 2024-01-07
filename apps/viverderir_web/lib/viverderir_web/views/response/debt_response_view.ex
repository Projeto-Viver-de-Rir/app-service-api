defmodule ViverderirWeb.Views.Response.DebtResponseView do
  def render("index.json", %{
    response: response_index
      }) do
        %{
          debts: Enum.map(response_index, fn(debt) -> debt_item(debt) end),
          max: 100
        }
  end

  defp debt_item(debt) do
    %{
      id: debt.id,
      name: debt.name,
      amount: debt.amount,
      due_date: debt.due_date,
      paid_at: debt.paid_at
    }
  end

  def render("detail.json", %{response: response_detail}) do
    debt_item(response_detail)
  end

  def render("create.json", %{response: response_create}) do
    %{
      id: response_create.id,
      name: response_create.name,
      amount: response_create.amount,
      due_date: response_create.due_date,
      paid_at: response_create.paid_at
    }
  end

  def render("update.json", %{response: response_update}) do
    %{
      id: response_update.id,
      name: response_update.name,
      amount: response_update.amount,
      due_date: response_update.due_date,
      paid_at: response_update.paid_at
    }
  end
end
