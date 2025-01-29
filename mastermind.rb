# frozen_string_literal = true

# a explicacao aparece na tela, agora falta todo o resto
# o programa precisa: 1) gerar um codigo de 4 numeros usando uma das 6 cores                             (X)
#                    2) fornecer uma forma do jogador jogar                                              (X)
#                    3) verificar quais dos numeros jogados equivalem aos numeros gerados                (X)
#                    4) mostrar o resultado ao jogador                                                   (X)
#                    5) repetir os passos 2-4 ate o 12 round ou o jogador acertar o codigo               (X)
#                    6) polir o resultado, oferecer uma UI 

require 'pry-byebug'
def color_squares(color)
  case color
  when 1
    "\e[41m  1  \e[0m"
  when 2
    "\e[42m  2  \e[0m"
  when 3                            #mais tarde voce provavelmente consegue diminuir o tamanho desses cases com algum
    "\e[43m  3  \e[0m"              #tipo de map
  when 4
    "\e[44m  4  \e[0m"
  when 5
    "\e[45m  5  \e[0m"
  when 6
    "\e[46m  6  \e[0m"
  end
end

def computer_code_generator
  Array.new(4) { rand(1..6) }
end

SEQUENCE = [1..6]

def game_start
  print 'type the color sequence'
  computer_code = code_generator
end

def game_intro
  print "Welcome to Mastermind \n the computer will use one of 6 colors to represent it's code\n "
  SEQUENCE.each { |n| print color_squares(n) }
  print "\nfor each correct guess in the correct position, you get a \e[40m \e[0m\n"
  print "for each correct guess in the incorrect position, you get a \e[47m \e[0m\n"
  print "the computer will generate a 4 color code, and you have to guess within 12 turns\n"
end

def play_round
  guess = false
  until guess
    print "Guess the colors\n"
    guess = gets.chomp
    if valid_input?(guess) == true
      print("Round played successfully\n")
    else
      print("Your answer should only contain numbers and only have 4 digits\n")
    end
  end
  print "Next round\n"
  guess
end

def valid_input?(input)
  test_input = Integer(input)
  if test_input.class == Integer && test_input.to_s.length == 4
    true
  end
rescue ArgumentError
  false
end

def calculate_score(code, guess)
  white_pins = code
  black_pins = guess
  w_result = white_pins.map.with_index { |a_code, index| a_code == black_pins[index] ? 1 : nil }
  b_result = black_pins.map { |b_code| white_pins.include?(b_code) ? 2 : nil }
  if w_result.compact.length == 4
    'End game'
  else
    [w_result.compact.length, b_result.compact.length - w_result.compact.length]
  end
end

def show_score(score)
  if score.instance_of?(Array)
    score[0].times { print "\e[37m ⬤\e[0m" }
    score[1].times { print "\e[30m ⬤\e[0m" }
  else
    'Game end'
  end
end

def play_game(rounds = 0)
  game_intro
  print computer_code = computer_code_generator
  while rounds <= 12
    rounds += 1
    player_guess = play_round.to_i.digits.reverse
    score = calculate_score(computer_code, player_guess)
    if score.instance_of?(String)
      print(show_score([4, 0]))
      rounds = 12
      break
    else
      print(show_score(score))
    end
  end
end

play_game
