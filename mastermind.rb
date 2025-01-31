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
  [5, 1, 4, 2]
end

SEQUENCE = [1, 2, 3, 4, 5, 6]

def game_start
  print 'type the color sequence'
  computer_code = code_generator
end

def game_intro
  print "Welcome to Mastermind \n the computer will use one of 6 colors to represent it's code\n "
  #binding.pry
  display_code(SEQUENCE)
  print "\nfor each correct guess in the correct position, you get a \e[37m ⬤\e[0m\n"
  print "for each correct guess in the incorrect position, you get a \e[30m ⬤\e[0m\n"
  print "the computer will generate a 4 color code, and you have to guess within 12 turns\n"
end

def play_round(round_number)
  guess = false
  until guess
    print "Guess the colors\n"
    guess = gets.chomp
    if valid_input?(guess) == true
      print("Round #{round_number} played successfully\n")
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
  b_result = black_pins.map.with_index { |b_code, index| white_pins[index] == b_code ? 2 : nil }
  if w_result.compact.length == 4
    'End game'
  else
    [w_result.compact.length, b_result.compact.length - w_result.compact.length]
  end
end

def show_score(score)
  if score.instance_of?(Array)
    score[0].times { print "\e[37m ⬤\e[0m  " }
    score[1].times { print "\e[30m ⬤\e[0m  " }
  else
    'Game end'
  end
end

def play_game(rounds = 0)
  game_intro
  print computer_code = computer_code_generator
  while rounds <= 12
    rounds += 1
    player_guess = play_round(rounds).to_i.digits.reverse
    score = calculate_score(computer_code, player_guess)
    if score.instance_of?(String)
      print(show_score([4, 0]))
      rounds = 12
      break
    else
      print("xdddddd #{show_score(score)}\n")
    end
  end
end

#play_game
print(color_squares(computer_code_generator))

def display_code(code)
  code.each { |pin| print color_squares(pin) }
end

play_game

# a funcao color_squares cospe seu quadrado colorido com numero. o computer code generator e so 4 digitos aleatorios
# correspondente ao codigo. voce pode criar uma funcao que use os dois para fazer display das opcoes selecionadas (X)

# 5142
# 1111

# proximo passos
# Arrumar quando se pula linha
# Conferir se o jogo funciona corretamente
# Mexa no gerador pra gerar sempre o mesmo numero e teste os uso-caso
# Adicione as correlacoes de numeros com cores
# Altere o inicio pra sair daquele quadrado preto esquisito que voce nao tava conseguindo mudar pras novas bolas
# coloridas