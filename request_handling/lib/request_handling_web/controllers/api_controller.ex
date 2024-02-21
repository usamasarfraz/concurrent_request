defmodule RequestHandlingWeb.ApiController do
  use RequestHandlingWeb, :controller

  def index(conn, _params) do
    conn
    # |> json(check_request(conn.body_params))
    |> json(%{status: 200, msg: "Successfully Received."})
  end

  def summary(conn, _params) do
    %{"user_id" => user_id} = conn.body_params
    {:ok, {count, count_remaining, ms_to_next_bucket, created_at, updated_at}} = Hammer.inspect_bucket("hammer_bucket:#{user_id}", 60000, 10)
    conn
    |> json(%{
      count: count,
      count_remaining: count_remaining,
      ms_to_next_bucket: ms_to_next_bucket,
      created_at: created_at,
      updated_at: updated_at
      })
  end

  def check_request(%{"user_id" => user_id}) do
    case Hammer.check_rate("hammer_bucket:#{user_id}", 60000, 10) do
      {:allow, count} ->
        %{status: 200, message: "Request Accepted. count: #{count}"}
      {:deny, limit} ->
        %{status: 429, message: "Request Rejected. limit: #{limit}"}
    end
  end

end
