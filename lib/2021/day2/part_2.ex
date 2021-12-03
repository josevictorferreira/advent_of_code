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
    |> Enum.reduce(%{horizontal: 0, depth: 0, aim: 0}, &step/2)
  end

  defp step([direction, value], %{horizontal: hv, depth: dv, aim: av}) when direction == :up do
    %{horizontal: hv, depth: dv, aim: av - value}
  end

  defp step([direction, value], %{horizontal: hv, depth: dv, aim: av}) when direction == :down do
    %{horizontal: hv, depth: dv, aim: av + value}
  end

  defp step([direction, value], %{horizontal: hv, depth: dv, aim: av}) when direction == :forward do
    %{horizontal: hv + value, depth: dv + (av * value), aim: av}
  end
end

directions = Dive.calculate_directions(input)
IO.puts(directions[:horizontal])
IO.puts(directions[:depth])
IO.puts("multiplied: " <> Integer.to_string(directions[:horizontal] * directions[:depth]))
