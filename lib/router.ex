defmodule Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  get "/route/:orig/:dest" do
    Metro.route(orig, dest)
    |> send_json_response(conn)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  def send_json_response(response, conn) do
    {:ok, json} = Poison.encode(response)
    conn
      |> put_resp_content_type("text/json")
      |> send_resp(200, json)
  end
end
