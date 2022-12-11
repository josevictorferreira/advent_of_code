# A, X = Rock
# B, Y = Paper
# C, Z = Scissor
# X = Lose
# Y = Draw
# Z = Win

SHAPE = {
  "X" => 1,
  "Y" => 2,
  "Z" => 3
}

LOSS = 0
DRAW = 3
WIN = 6

RESULT = {
 "X" => LOSS,
 "Y" => DRAW,
 "Z" => WIN
}

points = 0

content = File.each_line("./input") do |line|
  opp, play = line.split(" ")
  result = RESULT[play]
  actual_play = ""
  if opp == "A"
    actual_play = "Z" if play == "X"
    actual_play = "X" if play == "Y"
    actual_play = "Y" if play == "Z"
  elsif opp == "B"
    actual_play = "X" if play == "X"
    actual_play = "Y" if play == "Y"
    actual_play = "Z" if play == "Z"
  elsif opp == "C"
    actual_play = "Y" if play == "X"
    actual_play = "Z" if play == "Y"
    actual_play = "X" if play == "Z"
  end
  points += (result + SHAPE[actual_play])
end

puts points
