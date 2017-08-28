defmodule Codecamp2017 do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Router, [], [port: 4001])
    ]

    opts = [strategy: :one_for_one, name: Codecamp2017.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
