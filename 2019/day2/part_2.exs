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

  def search_noun(_, current_noun, last_noun, _) when current_noun == last_noun do
    IO.puts("Entrou")
    current_noun
  end

  def search_noun(values, current_noun, last_noun, searched_value) do
    new_values =
      values
      |> List.update_at(1, fn _ -> current_noun end)
      |> List.update_at(2, fn _ -> 0 end)

    result_values = check_opcode(0, new_values)
    output_value = Enum.at(result_values, 0)

    case output_value do
      value when abs(searched_value - value) < 100 ->
        [current_noun, abs(searched_value - output_value)]

      value when value < searched_value ->
        search_noun(
          values,
          trunc(floor(abs(last_noun - current_noun) / 2) + current_noun),
          current_noun,
          searched_value
        )

      value when value > searched_value ->
        search_noun(
          values,
          trunc(last_noun + floor(abs(last_noun - current_noun) / 2)),
          current_noun,
          searched_value
        )
    end
  end

  def search_noun_and_verb(values, searched_value) do
    [noun, verb] = search_noun(values, 50, 100, searched_value)
    [noun, verb]
  end

  def check_noun_and_verb(values, noun, verb) do
    new_values =
      values
      |> List.update_at(1, fn _ -> noun end)
      |> List.update_at(2, fn _ -> verb end)

    opcode =
      check_opcode(0, new_values)
      |> Enum.at(0)

    opcode
  end
end

[noun, verb] = Intcode.search_noun_and_verb(inputs, 19_690_720)
IO.puts(noun)
IO.puts(verb)

Intcode.check_noun_and_verb(inputs, 62, 55)
|> IO.puts()
