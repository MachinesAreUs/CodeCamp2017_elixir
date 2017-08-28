defmodule Metro.Reader do
  import SweetXml

  def metro_lines do
    kml      = read_kml()
    lines    = lines(kml)
    stations = stations(kml)
    Enum.map(lines, &complete_stations(&1, stations))
  end

  def read_kml do
    File.read!("priv/Metro_CDMX.kml")
  end

  def lines(kml) do
    xpath(kml, ~x"/kml/Document/Folder[1]/Placemark"l, 
      name: ~x"./name/text()" |> transform_by(&to_string/1), 
      coords: ~x".//coordinates/text()" |> transform_by(&Helpers.to_coordinates_list/1))
  end

  def stations(kml) do
    xpath(kml, ~x"/kml/Document/Folder[2]/Placemark"l,
      name: ~x"./name/text()" |> transform_by(&to_string/1),
      coords: ~x".//coordinates/text()" |> transform_by(&Helpers.to_coordinates/1))
  end

  def complete_stations(_line = %{name: name, coords: coords}, stations) do
    line_stations = 
      coords
      |> Enum.map(&coord_to_station(&1, stations))
      |> Enum.filter(&(&1))
    %{name: name, stations: line_stations}
  end

  def coord_to_station(coord, stations) do
    Enum.find(stations, fn(%{name: _name, coords: s_coord}) -> coord == s_coord end)
  end
end