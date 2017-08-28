defmodule Helpers do

  def to_coordinates_list(str) do
    str
    |> to_string()
    |> String.split("\n", trim: true)
    |> Enum.map(&to_coordinates/1)
    |> Enum.filter(&(&1 != {}))
  end

  def to_coordinates(str) when is_binary(str) do
     str
     |> String.trim() 
     |> String.split(",", trim: true) 
     |> Enum.take(2)
     |> List.to_tuple()
  end

  def to_coordinates(str) do
    str
    |> to_string() 
    |> to_coordinates()
  end
end