input =
  'lib/2021/day3/input'
  |> Path.absname
  |> File.read!
  |> String.split("\n", trim: true)

defmodule Freq do
  def calculate_freq_max(input_values, position) do
    input_values
    |> Enum.zip_with(fn values -> values end)
    |> Enum.fetch!(position)
    |> Enum.frequencies
    |> Map.merge(%{"0" => 0, "1" => 0}, fn _k, v1, v2 -> v1 + v2 end)
    |> Enum.sort_by(fn  {k, _v} -> k end, :desc)
    |> Enum.max_by(fn v -> v |> Kernel.elem(1) end)
    |> Kernel.elem(0)
  end

  def calculate_freq_min(input_values, position) do
    input_values
    |> Enum.zip_with(fn values -> values end)
    |> Enum.fetch!(position)
    |> Enum.frequencies
    |> Map.merge(%{"0" => 0, "1" => 0}, fn _k, v1, v2 -> v1 + v2 end)
    |> Enum.sort_by(fn  {k, _v} -> k end, :asc)
    |> Enum.min_by(fn v -> v |> Kernel.elem(1) end)
    |> Kernel.elem(0)
  end

  def calc_freq(remainder, pos, :oxygen) do
    calculate_freq_max(remainder, pos)
  end

  def calc_freq(remainder, pos, :o2) do
    calculate_freq_min(remainder, pos)
  end
end

defmodule BinaryDiagnostic do
  def calc_rating(input_values, type) do
    initial_binaries = input_values |> Enum.map(fn v -> v |> String.split("", trim: true) end)
    initial_binaries
    |> Enum.zip_with(fn values -> values end)
    |> Enum.reduce(%{remainder: initial_binaries, pos: 0}, fn _item, %{remainder: remainder, pos: pos} ->
      if Kernel.length(remainder) == 1 do
        %{remainder: remainder, pos: pos + 1}
      else
        freq = remainder |> Freq.calc_freq(pos, type)
        new_remainder = remainder |> Enum.filter(fn x -> Enum.fetch!(x, pos) == freq end)
        %{remainder: new_remainder, pos: pos + 1}
      end
    end)
    |> Map.get(:remainder)
    |> Enum.fetch!(0)
    |> Enum.join
    |> Integer.parse(2)
    |> Kernel.elem(0)
  end

  def life_support_rating(input_values) do
    calc_rating(input_values, :oxygen) * calc_rating(input_values, :o2)
  end
end

IO.puts(BinaryDiagnostic.life_support_rating(input))
