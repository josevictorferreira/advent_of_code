# 
# A Rock - Y Paper  - 2 + 6 = 8
# B Paper - X Rock - 1 + 0 = 1
# C Sczisor - Z Sciszor - Draw 3 + 3 = 6
# TOTAL SCORE = 15 
# A = Rockjj
# B = Paper
# C = Scissor
# X = Rock
# Y = Paper
# Z = Scissor

SHAPE = {
  "X" => 1,
  "Y" => 2,
  "Z" => 3
}

LOSS = 0
DRAW = 3
WIN = 6

points = 0

content = File.each_line("./input") do |line|
  opp, play = line.split(" ")
  result = 0
  if opp == "A"
    result = DRAW if play == "X"
    result = WIN if play == "Y"
    result = LOSS if play == "Z"
  elsif opp == "B"
    result = LOSS if play == "X"
    result = DRAW if play == "Y"
    result = WIN if play == "Z"
  elsif opp = "C"
    result = WIN if play == "X"
    result = LOSS if play == "Y"
    result = DRAW if play == "Z"
  end
  points += (result + SHAPE[play])
end

puts points
