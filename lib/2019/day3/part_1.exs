inputs =
  'input'
  |> File.read!()
  |> String.trim()
  |> String.split("\n")
  |> Enum.map(fn x -> String.split(x, ",") end)

defmodule ManhattanDistance do
  def distance_to_center([first_wire | [second_wire | []]]) do
    intersection_points(mount_wire(first_wire), mount_wire(second_wire))
    |> Enum.map(&manhattan_distance/1)
    |> Enum.min()
  end

  def manhattan_distance(%{x: x, y: y}) do
    abs(x) + abs(y)
  end

  def intersection_points(first_wire, second_wire) do
    MapSet.intersection(MapSet.new(first_wire), MapSet.new(second_wire))
  end

  def mount_wire(paths) do
    _mount_wire(paths, [], %{x: 0, y: 0})
  end

  defp _mount_wire([], positions, _) do
    positions
  end

  defp _mount_wire([instruction | paths], positions, current_position) do
    {direction, distance} = String.split_at(instruction, 1)
    new_positions = points_to_position(current_position, direction, String.to_integer(distance))
    current_all_positions = positions ++ new_positions
    _mount_wire(paths, current_all_positions, List.first(new_positions))
  end

  def points_to_position(current_position, direction, distance) do
    _points_to_position(direction, current_position, distance, [])
  end

  def _points_to_position(_, _, 0, positions) do
    positions
  end

  def _points_to_position(direction, curr_pos, distance, positions) do
    case direction do
      "U" ->
        _points_to_position(
          direction,
          curr_pos,
          distance - 1,
          positions ++ [%{x: curr_pos[:x], y: curr_pos[:y] + distance}]
        )

      "D" ->
        _points_to_position(
          direction,
          curr_pos,
          distance - 1,
          positions ++ [%{x: curr_pos[:x], y: curr_pos[:y] - distance}]
        )

      "R" ->
        _points_to_position(
          direction,
          curr_pos,
          distance - 1,
          positions ++ [%{x: curr_pos[:x] + distance, y: curr_pos[:y]}]
        )

      "L" ->
        _points_to_position(
          direction,
          curr_pos,
          distance - 1,
          positions ++ [%{x: curr_pos[:x] - distance, y: curr_pos[:y]}]
        )
    end
  end
end

ManhattanDistance.distance_to_center(inputs)
|> IO.puts()
