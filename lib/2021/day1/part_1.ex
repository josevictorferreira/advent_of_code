input =
  'input'
  |> File.read!
  |> String.split("\n", trim: true)


defmodule SonarSweep do
  def measure_count(input_values) do
    input_values
    |> Enum.map(fn value -> value |> String.to_integer end)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [first, second] -> second > first end)
  end
end

SonarSweep.measure_count(input)
|> IO.puts
