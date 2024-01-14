defmodule ViverderirWeb.Auth.Guardian do
  use Guardian, otp_app: :viverderir_web

  alias ViverDeRir.Accounts
  alias ViverderirWeb.Auth

  require Logger

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  # def subject_for_token(_, _) do
  #   {:error, :not_found}
  # end

  def resource_from_claims(claims) do
    id = claims["sub"]

    case Accounts.get_account(id) do
      {:ok, user} ->
        {:ok, user}

      {_, _} ->
        {:error, :not_found}
    end
  end

  def authenticate(email, password) do
    case Accounts.get_by_email(email) do
      {:ok, user} ->
        user_map = Map.from_struct(user)

        case validate_password(password, user_map.password_hash) do
          true -> create_token(user_map)
          false -> {:error, :unauthorized}
        end

      {_, _} ->
        {:error, :unauthorized}
    end
  end

  defp validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end

  defp create_token(account) do
    {:ok, token, _claims} = Auth.Guardian.encode_and_sign(account, %{some: "claim"})
    {:ok, account, token}
  end

end
