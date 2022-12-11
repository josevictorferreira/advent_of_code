input =
  'lib/2021/day2/input'
  |> Path.absname
  |> File.read!
  |> String.split("\n", trim: true)

defmodule Dive do
  def calculate_directions(input_values) do
    input_values
    |> Enum.map(fn value -> value |> String.split end)
    |> Enum.map(fn [direction, value] -> [String.to_atom(direction), String.to_integer(value)] end)
    |> Enum.group_by(&List.first/1, &List.last/1)
    |> Enum.map(fn {k, v} -> {k, Enum.sum(v)} end)
  end
end

directions = Dive.calculate_directions(input)
horizontal = directions[:forward]
depth = directions[:down] - directions[:up]
IO.puts(depth)
IO.puts(horizontal)
IO.puts("multiplied: " <> Integer.to_string(horizontal * depth))
