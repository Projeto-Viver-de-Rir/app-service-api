defmodule ViverderirWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :viverderir_web,
  module: ViverderirWeb.Auth.Guardian,
  error_handler: ViverderirWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
