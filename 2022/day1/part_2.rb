# frozen_string_literal: true

require 'pry'

INPUT_FILE_NAME = './input'

def calc_max_calories
  File.open(INPUT_FILE_NAME, 'r') do |f|
    calories = f.read.split("\n\n").map(&:split).collect do |v|
      v.map(&:to_i).sum
    end.sort
    calories[-3..].sum
  end
end

puts calc_max_calories
