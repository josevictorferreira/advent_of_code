input =
  'input'
  |> File.read!()
  |> String.trim()
  |> String.split()
  |> Enum.map(&String.to_integer/1)

defmodule FuelRequirement do
  def fuel_needed(value) do
    Float.floor(value / 3) - 2
  end

  def all_fuel_needed(values) do
    Enum.reduce(values, 0, fn x, acc -> fuel_needed(x) + acc end)
    |> Kernel.trunc()
  end
end

FuelRequirement.all_fuel_needed(input)
|> IO.puts()
