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
  # Array.new(4) { rand(1..6) }
  [2, 2, 2, 2]
end

SEQUENCE = [1, 2, 3, 4, 5, 6]

def game_start
  print 'type the color sequence'
  computer_code = code_generator
end

def game_intro
  print "Welcome to Mastermind \n you or the computer will use one of 6 colors to represent its code\n "
  display_code(SEQUENCE)
  print "\nfor each correct guess in the correct position, you get a \e[37m ⬤\e[0m\n"
  print "for each correct guess in the incorrect position, you get a \e[30m ⬤\e[0m\n"
  print "you can choose to be the code master or the code breaker\n"
  print "by being the code master, the computer will try to guess your code\n"
  print "by being the code breaker, the computer will generate a 4 color code,\n"
  print "and you have to guess within 12 turns\n"
end

def play_round(round_number)
  guess = false
  until guess
    print "Guess the colors\n"
    guess = gets.chomp
    if valid_guess?(guess) == true
      print("Round #{round_number + 1} played successfully\n")
    else
      print("Your answer should only contain numbers and only have 4 digits\n")
    end
  end
  print "Next round\n"
  guess
end

def valid_guess?(input)
  test_input = Integer(input)
  if test_input.class(Integer) && test_input.to_s.length == 4
    true
  end
rescue ArgumentError
  false
end

def valid_input?(input)
  test_input = Integer(input)
  if test_input.class == Integer
    true
  end
rescue ArgumentError
  false
end

def show_score(score)
  if score.instance_of?(Array)
    score[0].times { print "\e[37m ⬤\e[0m  " }
    score[1].times { print "\e[30m ⬤\e[0m  " }
    return # return very much needed, else the times method prints a phantom 0
  else
    'Game end'
  end
end

def play_game(rounds = 12)
  # game_intro
  print computer_code = computer_code_generator
  rounds.times do |round|
    player_guess = play_round(round).to_i.digits.reverse
    score = new_calculate_score(computer_code, player_guess)
    if score.instance_of?(String)
      print(show_score([4, 0]))
      break
    else
      print(show_score(score))
    end
  end
end

def display_code(code)
  code.each { |pin| print color_squares(pin) }
end

def new_calculate_score(code, guess)
  white_pin_tally = guess.map.with_index { |pegs, index| pegs == code[index] ? index : nil }
  black_pin_tally = code.map.with_index { |pegs, index| guess.include?(pegs) ? index : nil }
  # binding.pry
  if white_pin_tally.compact.length == 4
    'Game Over'
  else
    [white_pin_tally.compact.length, black_pin_tally.compact.length - white_pin_tally.compact.length]
  end
end

def mode_selector(mode)
  case mode
  when 'breaker'
    rounds = false
    until rounds
      print "Choose the amount of rounds \nDefault: 12\n"
      rounds = gets.chomp
      if valid_input?(rounds) == true
        play_game(rounds.to_i)
      else
        print("Only numbers are valid\n")
        rounds = false
      end
    end
  when 'master'
    game_intro
    player_code = player_code_master
    computer_playing(player_code)
  end
end

def player_code_master
  print("Type the number/color sequence you'd like the computer to guess\n")
  player_code = false
  until player_code
    player_code = gets.chomp
    if valid_input?(player_code) == true && player_code.length == 4
      print("Your code is \n")
      display_code(player_code.to_i.digits.reverse)
    else
      print("Your answer must contain only four digits, from 1 to 6.\n")
      player_code = false
    end
  end
  player_code.to_i.digits.reverse
end

def computer_playing(player_code)
  12.times do
    print("The computer will now guess\n")
    random_guess = computer_code_generator
    sleep 1
    print("the computer guesses\n")
    display_code(random_guess)
    sleep 1
    print ("the computer scores \n")
    computer_score = new_calculate_score(player_code, random_guess)
    print("#{show_score(computer_score)} \n")
    sleep 1
    if computer_score == 'Game Over'
      print('The computer won')
      break
    end
  end
end

def computer_code_breaker(last_result, guess)

end
# def computer_rng

mode_selector('master')

# na sua versao de mastermind, os pinos funcionam errado. pinos certos em locais errados contam mesmo se forem
# repetidos. no codigo (1111) com o chute (1222), a resposta seria (1, 3) pra pinos brancos e pretos
