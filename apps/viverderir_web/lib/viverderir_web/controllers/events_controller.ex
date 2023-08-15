defmodule ViverderirWeb.EventsController do
  use ViverderirWeb, :controller

  def index(conn, _params) do
    list = ~s({"events":[{"id":1,"name":"Event 1","description":"Description 1","address":"Address 1","city":"City 1","meeting_point":"Meeting Point 1","date":"Date 1","time":"Time 1","occupancy":10,"organizer":1,"finalized":false},{"id":2,"name":"Event 2","description":"Description 2","address":"Address 2","city":"City 2","meeting_point":"Meeting Point 2","date":"Date 2","time":"Time 2","occupancy":10,"organizer":1,"finalized":false}]})

    conn
    |> send_resp(200, list)
  end

  def detail(conn, %{"id" => id}) do
    item = ~s({"event":{"id":1,"name":"Event 1","description":"Description 1","address":"Address 1","city":"City 1","meeting_point":"Meeting Point 1","date":"Date 1","time":"Time 1","occupancy":10,"organizer":1,"finalized":false,"volunteers":[{"id":1,"name":"Volunteer 1","photo":"Photo","event_id":1},{"id":2,"name":"Volunteer 2","photo":"Photo","event_id":1}]}})

    conn
    |> send_resp(200, item)
  end

  def create(conn, _params) do
    Map.get(conn, :body_params)

    item = ~s({"event":{"id":1,"name":"Event 1","description":"Description 1","address":"Address 1","city":"City 1","meeting_point":"Meeting Point 1","date":"Date 1","time":"Time 1","occupancy":10,"organizer":1,"finalized":false,"volunteers":[{"id":1,"name":"Volunteer 1","photo":"Photo","event_id":1},{"id":2,"name":"Volunteer 2","photo":"Photo","event_id":1}]}})

    conn
    |> send_resp(201, item)
  end

  def update(conn, %{"id" => id}) do
    Map.get(conn, :body_params)

    item = ~s({"event":{"id":1,"name":"Event 1","description":"Description 1","address":"Address 1","city":"City 1","meeting_point":"Meeting Point 1","date":"Date 1","time":"Time 1","occupancy":10,"organizer":1,"finalized":false,"volunteers":[{"id":1,"name":"Volunteer 1","photo":"Photo","event_id":1},{"id":2,"name":"Volunteer 2","photo":"Photo","event_id":1}]}})

    conn
    |> send_resp(200, item)
  end

  def patch(conn, %{"id" => id}) do
    Map.get(conn, :body_params)

    item = ~s({"event":{"id":1,"name":"Event 1","description":"Description 1","address":"Address 1","city":"City 1","meeting_point":"Meeting Point 1","date":"Date 1","time":"Time 1","occupancy":10,"organizer":1,"finalized":false,"volunteers":[{"id":1,"name":"Volunteer 1","photo":"Photo","event_id":1},{"id":2,"name":"Volunteer 2","photo":"Photo","event_id":1}]}})

    conn
    |> send_resp(200, item)
  end

  def delete(conn, %{"id" => id}) do
    Map.get(conn, :body_params)

    item = ~s({"event":{"id":1,"name":"Event 1","description":"Description 1","address":"Address 1","city":"City 1","meeting_point":"Meeting Point 1","date":"Date 1","time":"Time 1","occupancy":10,"organizer":1,"finalized":false,"volunteers":[{"id":1,"name":"Volunteer 1","photo":"Photo","event_id":1},{"id":2,"name":"Volunteer 2","photo":"Photo","event_id":1}]}})

    conn
    |> send_resp(204, item)
  end
end
