defmodule ViverderirWeb.Views.Request.DebtRequestView do
  alias Domain.Debts

  require Logger

  @spec to_domain_from_create_request(nil | maybe_improper_list | map) ::
          {:error, :validation_failed} | {:ok, Domain.Debts.t()}
  def to_domain_from_create_request(params) do
    %{
      id: nil,
      name: params["name"],
      description: params["description"],
      amount: params["amount"],
      due_date: params["due_date"],
      volunteer_id: params["volunteer_id"],
      paid_at: params["paid_at"],
      paid_by: params["paid_by"]
    }
    |> Debts.cast_domain()
  end

  @spec to_domain_from_update_request(nil | maybe_improper_list | map, any) ::
          {:error, :validation_failed} | {:ok, Domain.Debts.t()}
  def to_domain_from_update_request(params, id) do
    %{
      id: id,
      name: params["name"],
      description: params["description"],
      amount: params["amount"],
      due_date: params["due_date"],
      volunteer_id: params["volunteer_id"],
      paid_at: params["paid_at"],
      paid_by: params["paid_by"]
    }
    |> Debts.cast_domain()
  end
end
