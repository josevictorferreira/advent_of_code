input =
  'lib/2021/day3/input'
  |> Path.absname
  |> File.read!
  |> String.split("\n", trim: true)

defmodule BinaryDiagnostic do
  def gamma_and_epsilon_rate(input_values) do
    input_values
    |> Enum.map(fn v -> v |> String.split("", trim: true) end)
    |> Enum.zip_with(fn values -> values end)
    |> Enum.map(&Enum.frequencies/1)
    |> Enum.map(fn v -> v |> Enum.sort_by(fn {_k, v} -> v end, :desc) end)
    |> Enum.map(fn v -> v |> Enum.map(fn k -> Kernel.elem(k, 0) end) end)
    |> Enum.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(fn v -> v |> Integer.parse(2) |> elem(0) end)
    |> Enum.product
  end
end

IO.puts(BinaryDiagnostic.gamma_and_epsilon_rate(input))
