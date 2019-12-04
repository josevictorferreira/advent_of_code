input =
  'input'
  |> File.read!()
  |> String.trim()
  |> String.split()
  |> Enum.map(&String.to_integer/1)

defmodule FuelRequirement do
  def fuel_calc(value) do
    Float.floor(value / 3) - 2
  end

  def fuel_needed(value) do
    _fuel_needed(value, 0)
  end

  defp _fuel_needed(value, sum) when value > 8 do
    fuel = fuel_calc(value)
    _fuel_needed(fuel, fuel + sum)
  end

  defp _fuel_needed(_, sum) do
    sum
    |> Kernel.trunc()
  end

  def all_fuel_needed(values) do
    Enum.reduce(values, 0, fn x, acc -> fuel_needed(x) + acc end)
  end
end

FuelRequirement.all_fuel_needed(input)
|> IO.puts()
