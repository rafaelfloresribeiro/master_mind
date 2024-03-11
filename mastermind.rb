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
  
end

print code_guessing([1, 1, 1, 1], [1, 1, 2, 2])

