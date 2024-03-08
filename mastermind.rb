# literal_frozen_string = true
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
  code_breaking = []
  opponent_code.each do |code_color|
    player_guess.each.with_index do |play_color, index|
      if code_color[index] == play_color[index]
        code_breaking << 2
      elsif code_color[index] == play_color
        code_breaking << 1
    end
  end
end

a = code_generator
print a
a.each do |element|
print color_squares(element)
end
