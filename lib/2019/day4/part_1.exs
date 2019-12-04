input =
  'input'
  |> File.read!()
  |> String.trim()
  |> String.split("-")
  |> Enum.map(&String.to_integer/1)

defmodule CheckPasswords do
  def check_range([init | [final | []]]) do
    Enum.to_list(init..final)
    |> Enum.map(&Integer.to_string/1)
    |> Enum.filter(fn x -> String.match?(x, ~r/(?=.*(\d)\1.*)(?=^1*2*3*4*5*6*7*8*9*$)/) end)
    |> length()
  end
end

CheckPasswords.check_range(input)
|> IO.inspect()
