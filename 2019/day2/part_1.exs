inputs =
  'input'
  |> File.read!()
  |> String.trim()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

defmodule Intcode do
  def change_position(values, position, value) do
    List.update_at(values, position, fn _ -> value end)
  end

  def check_opcode(position, values) do
    case Enum.at(values, position, :none) do
      99 ->
        values

      1 ->
        check_opcode(
          position + 4,
          change_position(
            values,
            Enum.at(values, position + 3),
            Enum.at(values, Enum.at(values, position + 1)) +
              Enum.at(values, Enum.at(values, position + 2))
          )
        )

      2 ->
        check_opcode(
          position + 4,
          change_position(
            values,
            Enum.at(values, position + 3),
            Enum.at(values, Enum.at(values, position + 1)) *
              Enum.at(values, Enum.at(values, position + 2))
          )
        )

      :none ->
        values
    end
  end
end

Intcode.check_opcode(0, inputs)
|> Enum.at(0)
|> IO.puts()
