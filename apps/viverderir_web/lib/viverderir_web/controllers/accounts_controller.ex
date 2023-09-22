defmodule ViverderirWeb.AccountsController do
  use ViverderirWeb, :controller

  def get_me(conn, _params) do
    item =
      ~s({"account":{"id":1,"name":"Account 1","email":"account@account.com","email_confirmed":true,"photo":"string","password":"xxxxxxxxx","password_hash":"xxxxxxxxx","access_failed_count":0,"lockout":"xxxxxxxxx","created_at":"2019-01-01 00:00:00","created_by":"1","updated_at":"2019-01-01 00:00:00","updated_by":"1","deleted_at":null,"deleted_by":null}})

    conn
    |> send_resp(200, item)
  end

  def sign_in(conn, _params) do
    item =
      ~s({"token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJWaXZlci1EZS1SaXIiLCJpYXQiOjE2OTIxMDUwMTAsImV4cCI6MTcyMzY0MTAxMiwiYXVkIjoid3d3LnByb2pldG92aXZlcmRlcmlyLmNvbS5iciIsInN1YiI6ImFjY291bnRAYWNjb3VudC5jb20iLCJhY2NvdW50X2lkIjoiMSIsImFjY291bnRfbmFtZSI6IkFjY291bnQgMSIsImFjY291bnRfZW1haWwiOiJhY2NvdW50QGFjY291bnQuY29tIiwiYWNjb3VudF9wZXJtaXNzaW9ucyI6WyJhZG1pbmlzdHJhdG9yIiwibW9kZXJhdG9yIiwidm9sdW50ZWVyIl0sImFjY291bnRfcGhvdG8iOiJodHRwczovL2F2YXRhcnMuZ2l0aHVidXNlcmNvbnRlbnQuY29tL3UvMTgwNTEwNjA_dj00In0.BT-mZ3HD_hZyzb6blrfdpK9Hw-PB0qPZbtMfNV-LL1g"})

    conn
    |> send_resp(200, item)
  end

  def sign_up(conn, _params) do
    item =
      ~s({"token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJWaXZlci1EZS1SaXIiLCJpYXQiOjE2OTIxMDUwMTAsImV4cCI6MTcyMzY0MTAxMiwiYXVkIjoid3d3LnByb2pldG92aXZlcmRlcmlyLmNvbS5iciIsInN1YiI6ImFjY291bnRAYWNjb3VudC5jb20iLCJhY2NvdW50X2lkIjoiMSIsImFjY291bnRfbmFtZSI6IkFjY291bnQgMSIsImFjY291bnRfZW1haWwiOiJhY2NvdW50QGFjY291bnQuY29tIiwiYWNjb3VudF9wZXJtaXNzaW9ucyI6WyJhZG1pbmlzdHJhdG9yIiwibW9kZXJhdG9yIiwidm9sdW50ZWVyIl0sImFjY291bnRfcGhvdG8iOiJodHRwczovL2F2YXRhcnMuZ2l0aHVidXNlcmNvbnRlbnQuY29tL3UvMTgwNTEwNjA_dj00In0.BT-mZ3HD_hZyzb6blrfdpK9Hw-PB0qPZbtMfNV-LL1g"})

    conn
    |> send_resp(200, item)
  end

  def sign_out(conn, _params) do
    item = ~s({"account":{}, "token": ""})

    conn
    |> send_resp(200, item)
  end

  def delete(conn, _params) do
    item = ~s({"account":{}, "token": ""})

    conn
    |> send_resp(204, item)
  end
end
