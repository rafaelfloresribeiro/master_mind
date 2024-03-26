# frozen_string_literal = true
require 'pry-byebug'
def color_squares(color)
  case color
  when 1
    "\e[41m  1  \e[0m"
  when 2
    "\e[42m  2  \e[0m"
  when 3
    "\e[43m  3  \e[0m"
  when 4
    "\e[44m  4  \e[0m"
  end
end

def code_generator
  Array.new(4) { rand(1..4) }
end

def code_guessing(opponent_code, player_guess)
  code_guess = opponent_code.map.with_index do |_, code_index|
    opponent_code[code_index] == player_guess[code_index] ? 2 : nil
  end
  next_guess = code_guess.compact.length
  return code_guess unless next_guess < 4

  code_guess.compact << player_guess[next_guess..3].map do |guess|
    opponent_code[next_guess..3].include?(guess)
  end
end

SEQUENCE = [1, 2, 3, 4]

def game_start
  computer_code = code_generator
  print 'type the color sequence'

def game_intro
  p 'Welcome to Mastermind /n you can use one of 4 colors/n to represent your code/n example: '
  SEQUENCE.each { |n| print color_squares(n) }
  p 'for the code 1234'
  print "for each correct guess in the correct position, you get a \e[40m \e[0m\n"
  print "for each correct guess in the incorrect position, you get a \e[47m \e[0m\n"
  print 'the computer will generate a code, and you have to guess'
end

game_intro