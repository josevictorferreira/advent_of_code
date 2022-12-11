# Lowercase item types a through z have priorities 1 through 26.
# Uppercase item types A through Z have priorities 27 through 52.

ALPHABET = ('a'..'z').to_a + ('A'..'Z').to_a

def find_common_item(line)
  size = (line.size / 2).to_i
  first_half = line[..(size - 1)].chars
  second_half = line[size..].chars
  puts "FIRST HALF: #{first_half}"
  puts "SECOND HALF: #{second_half}"
  first_half.each do |ch|
    return ch if second_half.include? ch
  end
end

total_sum = 0
File.readlines('./input').each do |line|
  puts line
  common_item = find_common_item(line)
  puts "COMMON ITEM: #{common_item}"
  alphabet_index = ALPHABET.find_index(common_item)
  break if alphabet_index.nil?

  priority = alphabet_index + 1
  total_sum += priority
end

puts total_sum
