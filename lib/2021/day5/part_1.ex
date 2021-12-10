lines =
  'lib/2021/day5/input'
  |> Path.absname
  |> File.read!
  |> String.split("\n", trim: true)
  |> Enum.map(fn x ->
    x |> String.split([",", " -> "]) |> Enum.map(&String.to_integer/1)
  end)


defmodule Hydro do
  def overlap_vents(lines) do
    lines
    |> Enum.reduce(%{}, fn item, col ->
      case item do
        [x, y1, x, y2] ->
          y1..y2 |> Enum.reduce(col, fn v, col ->
            Map.update(col, {x, v}, 1, fn val -> val + 1 end)
          end)
        [x1, y, x2, y] ->
          x1..x2 |> Enum.reduce(col, fn v, col ->
            Map.update(col, {v, y}, 1, fn val -> val + 1 end)
          end)
        _ ->
          col
      end
    end)
    |> Enum.count(fn {_, v} ->
      v > 1
    end)
  end
end

IO.puts(Hydro.overlap_vents(lines))
