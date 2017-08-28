defmodule Metro do

  def route(orig, dest) do
    Metro.Reader.metro_lines()
    |> to_graph()
    |> find_route(orig, dest)    
  end

  def to_graph(metro_lines) do
    Enum.reduce(metro_lines, Graph.new() , fn(%{stations: stations}, graph) -> 
      {new_graph, _} = Enum.reduce(stations, {graph, :empty}, &add_edge(&1, &2))
      new_graph
    end)
  end

  def add_edge(%{name: cur}, {graph, :empty}) do
    {graph, cur}
  end

  def add_edge(%{name: cur}, {graph, prev}) do
    new_graph = Graph.add_edge(graph, prev, cur) |> Graph.add_edge(cur, prev)
    {new_graph, cur}
  end

  def find_route(graph, orig, dest) do
    Graph.dijkstra(graph, orig, dest)  
  end
end 