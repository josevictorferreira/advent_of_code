input =
  'lib/2021/day4/input'
  |> Path.absname
  |> File.read!
  |> String.split("\n\n")

boards =
  input
  |> List.delete_at(0)
  |> Enum.map(fn x ->
    x
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn x1 -> x1 |> Enum.map(fn v -> {String.to_integer(v), 0} end) end)
  end)

plays =
  input
  |> Enum.fetch!(0)
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

defmodule Bingo do
  def play_bingo(plays, boards) do
    plays
    |> Enum.reduce_while(boards, fn item, collector ->
      rem_boards = collector |> Enum.map(fn x -> x |> Bingo.mark_value(item) end)
      won_board = rem_boards |> Enum.filter(&Bingo.check_if_won/1)
      if (Enum.empty?(won_board)) do
        {:cont, rem_boards}
      else
        {:halt, item * Bingo.sum_blanks(Enum.fetch!(won_board, 0))}
      end
    end) 
  end

  def check_if_won(board) do
    check_if_won_row(board) || check_if_won_col(board)
  end

  def mark_value(board, value) do
    board
    |> Enum.map(fn x ->
      x |> Enum.map(fn {v, m} ->
        if v == value do {v, 1} else {v, m} end
      end)
    end)
  end

  def sum_blanks(board) do
    board
    |> Enum.reduce(0, fn item, collector ->
      collector + (item |> Enum.map(fn {x, v} -> if v == 0 do x else 0 end end) |> Enum.sum)
    end)
  end

  defp check_if_won_row(board) do
    board
    |> Enum.map(fn x -> Enum.all?(x, fn v -> elem(v, 1) == 1 end) end)
    |> Enum.any?
  end

  defp check_if_won_col(board) do
    board
    |> Enum.zip_with(fn v -> v end)
    |> Enum.map(fn x -> Enum.all?(x, fn v -> elem(v, 1) == 1 end) end)
    |> Enum.any?
  end
end

IO.puts(Bingo.play_bingo(plays, boards))
