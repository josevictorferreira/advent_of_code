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

  def minimal_steps([first_wire | [second_wire | []]]) do
    mount_first_wire = mount_wire(first_wire)
    mount_second_wire = mount_wire(second_wire)

    intersection_points(mount_first_wire, mount_second_wire)
    |> Enum.map(fn x ->
      Enum.find(mount_first_wire, fn y ->
        y[:x] == x[:x] && y[:y] == x[:y]
      end)[:dist] +
        Enum.find(mount_second_wire, fn y ->
          y[:x] == x[:x] && y[:y] == x[:y]
        end)[:dist]
    end)
    |> Enum.min()
  end

  def manhattan_distance(%{x: x, y: y}) do
    abs(x) + abs(y)
  end

  def intersection_points(first_wire, second_wire) do
    f_wire = first_wire |> Enum.map(fn x -> Map.delete(x, :dist) end) |> MapSet.new()
    s_wire = second_wire |> Enum.map(fn x -> Map.delete(x, :dist) end) |> MapSet.new()
    MapSet.intersection(f_wire, s_wire)
  end

  def mount_wire(paths) do
    _mount_wire(paths, [], %{x: 0, y: 0, dist: 0})
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
          positions ++
            [
              %{
                x: curr_pos[:x],
                y: curr_pos[:y] + distance,
                dist: curr_pos[:dist] + abs(distance)
              }
            ]
        )

      "D" ->
        _points_to_position(
          direction,
          curr_pos,
          distance - 1,
          positions ++
            [
              %{
                x: curr_pos[:x],
                y: curr_pos[:y] - distance,
                dist: curr_pos[:dist] + abs(distance)
              }
            ]
        )

      "R" ->
        _points_to_position(
          direction,
          curr_pos,
          distance - 1,
          positions ++
            [
              %{
                x: curr_pos[:x] + distance,
                y: curr_pos[:y],
                dist: curr_pos[:dist] + abs(distance)
              }
            ]
        )

      "L" ->
        _points_to_position(
          direction,
          curr_pos,
          distance - 1,
          positions ++
            [
              %{
                x: curr_pos[:x] - distance,
                y: curr_pos[:y],
                dist: curr_pos[:dist] + abs(distance)
              }
            ]
        )
    end
  end
end

ManhattanDistance.minimal_steps(inputs)
|> IO.inspect()
