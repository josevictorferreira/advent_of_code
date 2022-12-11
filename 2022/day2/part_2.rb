# A, X = Rock
# B, Y = Paper
# C, Z = Scissor
# X = Lose
# Y = Draw
# Z = Win

SHAPE = {
  'X' => 1,
  'Y' => 2,
  'Z' => 3
}.freeze

LOSS = 0
DRAW = 3
WIN = 6

RESULT = {
  'X' => LOSS,
  'Y' => DRAW,
  'Z' => WIN
}.freeze

points = 0

File.readlines('./input').each do |line|
  opp, play = line.split(' ')
  result = RESULT[play]
  actual_play = ''
  case opp
  when 'A'
    actual_play = 'Z' if play == 'X'
    actual_play = 'X' if play == 'Y'
    actual_play = 'Y' if play == 'Z'
  when 'B'
    actual_play = 'X' if play == 'X'
    actual_play = 'Y' if play == 'Y'
    actual_play = 'Z' if play == 'Z'
  when 'C'
    actual_play = 'Y' if play == 'X'
    actual_play = 'Z' if play == 'Y'
    actual_play = 'X' if play == 'Z'
  end
  points += (result + SHAPE[actual_play])
end

puts points
