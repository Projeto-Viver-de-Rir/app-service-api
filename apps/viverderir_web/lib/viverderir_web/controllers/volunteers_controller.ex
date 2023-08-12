defmodule ViverderirWeb.VolunteersController do
  use ViverderirWeb, :controller

  def index(conn, _params) do
    list = ~s({"volunteers":[{"id":1,"name":"Volunteer 1","nickname":"Nickname 1","email":"volunteer1@gmail.com","phone":"1234567890","city":"City 1","status":"Status 1"},{"id":2,"name":"Volunteer 2","nickname":"Nickname 2","email":"volunteer2@gmail.com","phone":"1234567890","city":"City 2","status":"Status 1"}]})

    conn
    |> send_resp(200, list)
  end

  def detail(conn, %{"id" => id}) do
    item = ~s({"volunteer":{"id":1,"name":"Volunteer 1","nickname":"Nickname 1","email":"volunteer1@gmail.com","phone":"1234567890","address":"Address 1","city":"City 1","state":"State 1","zip":"12345","birth_date":"1990-01-01 00:00:00","identifier":"Identifier 1","availability":"Availability 1","comments":"Comment 1","status":"Status 1","created_at":"2019-01-01 00:00:00","created_by":1,"updated_at":"2019-01-01 00:00:00","updated_by":1,"deleted_at":null,"deleted_by":null}})

    conn
    |> send_resp(200, item)
  end

  def create(conn, _params) do
    Map.get(conn, :body_params)

    item = ~s({"volunteer":{"id":1,"name":"Volunteer 1","nickname":"Nickname 1","email":"volunteer1@gmail.com","phone":"1234567890","address":"Address 1","city":"City 1","state":"State 1","zip":"12345","birth_date":"1990-01-01 00:00:00","identifier":"Identifier 1","availability":"Availability 1","comments":"Comment 1","status":"Status 1","created_at":"2019-01-01 00:00:00","created_by":1,"updated_at":"2019-01-01 00:00:00","updated_by":1,"deleted_at":null,"deleted_by":null}})

    conn
    |> send_resp(201, item)
  end

  def update(conn, %{"id" => id}) do
    Map.get(conn, :body_params)

    item = ~s({"volunteer":{"id":1,"name":"Volunteer 1","nickname":"Nickname 1","email":"volunteer1@gmail.com","phone":"1234567890","address":"Address 1","city":"City 1","state":"State 1","zip":"12345","birth_date":"1990-01-01 00:00:00","identifier":"Identifier 1","availability":"Availability 1","comments":"Comment 1","status":"Status 1","created_at":"2019-01-01 00:00:00","created_by":1,"updated_at":"2019-01-01 00:00:00","updated_by":1,"deleted_at":null,"deleted_by":null}})

    conn
    |> send_resp(200, item)
  end

  def patch(conn, %{"id" => id}) do
    Map.get(conn, :body_params)

    item = ~s({"volunteer":{"id":1,"name":"Volunteer 1","nickname":"Nickname 1","email":"volunteer1@gmail.com","phone":"1234567890","address":"Address 1","city":"City 1","state":"State 1","zip":"12345","birth_date":"1990-01-01 00:00:00","identifier":"Identifier 1","availability":"Availability 1","comments":"Comment 1","status":"Status 1","created_at":"2019-01-01 00:00:00","created_by":1,"updated_at":"2019-01-01 00:00:00","updated_by":1,"deleted_at":null,"deleted_by":null}})

    conn
    |> send_resp(200, item)
  end

  def delete(conn, %{"id" => id}) do
    Map.get(conn, :body_params)

    item = ~s({"volunteer":{"id":1,"name":"Volunteer 1","nickname":"Nickname 1","email":"volunteer1@gmail.com","phone":"1234567890","address":"Address 1","city":"City 1","state":"State 1","zip":"12345","birth_date":"1990-01-01 00:00:00","identifier":"Identifier 1","availability":"Availability 1","comments":"Comment 1","status":"Status 1","created_at":"2019-01-01 00:00:00","created_by":1,"updated_at":"2019-01-01 00:00:00","updated_by":1,"deleted_at":null,"deleted_by":null}})

    conn
    |> send_resp(204, item)
  end
end
