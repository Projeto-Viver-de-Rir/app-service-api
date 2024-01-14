defmodule ViverderirWeb.Auth.ErrorResponse.Unauthorized do
  @moduledoc """
  This module is responsible for generating the error response
  """

  defexception [message: "Unauthorized", plug_status: 401]
end
