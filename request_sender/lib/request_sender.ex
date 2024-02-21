defmodule RequestSender do
  def send_request(targetHour, targetMinute) do
    :hackney_pool.start_pool(:first_pool, [timeout: 15000000, max_connections: 108000])
    {:ok,targetTime} = Time.new(targetHour,targetMinute,10,307000)
    url = "http://localhost:4000/api/"
    body = Poison.encode!(%{number: 10})
    1..25000
    |> Enum.map(fn _counter -> Task.async(fn -> handle_request(targetTime, url, body) end) end)
    # |> Enum.map(&Task.await(&1))
    # |> Enum.map(fn task -> IO.inspect(task) end)
  end

  defp handle_request(targetTime, url, body) do
    currentTime = Time.utc_now()
    timeDiff = Time.diff(targetTime, currentTime, :millisecond)
    # IO.inspect(timeDiff)
    Process.sleep(timeDiff)
    resp = HTTPoison.post(url,body,[{"Content-Type", "application/json"}],hackney: [pool: :first_pool])
    # resp = HTTPoison.request(:post,url,body,[{"Content-Type", "application/json"}])
    # data = Poison.decode!(resp.body)
    IO.inspect(resp)
  end
end
# RequestSender.send_request(10,43)
