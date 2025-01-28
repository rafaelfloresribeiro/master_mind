# frozen_string_literal = true

# a explicacao aparece na tela, agora falta todo o resto
# o programa precisa: 1) gerar um codigo de 4 numeros usando uma das 6 cores                             (X)
#                    2) fornecer uma forma do jogador jogar                                              (X)
#                    3) verificar quais dos numeros jogados equivalem aos numeros gerados                (X)
#                    4) mostrar o resultado ao jogador                                                   (X)
#                    5) repetir os passos 2-4 ate o 12 round ou o jogador acertar o codigo               ( )

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

SEQUENCE = [1, 2, 3, 4, 5, 6]

def game_start
  computer_code = code_generator
  print 'type the color sequence'
end

def game_intro
  print "Welcome to Mastermind \n the computer will use one of 6 colors to represent it's code\n "
  SEQUENCE.each { |n| print color_squares(n) }
  print "\nfor each correct guess in the correct position, you get a \e[40m \e[0m\n"
  print "for each correct guess in the incorrect position, you get a \e[47m \e[0m\n"
  print "the computer will generate a 4 color code, and you have to guess within 12 turns\n"
end

def play_round
  for round in 1..12
    guess = false
    until guess
      print "Guess the colors\n"
      guess = gets.chomp
      if valid_input?(guess) == true
        print ('Round played successfully')
        print(round, "\n")
      else
        print("Your answer should only contain numbers and only have 4 digits\n")
        print(round)
        guess = false
      end
    end
  end
  print "Next round\n"
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
  white_pins = code.digits.reverse
  black_pins = guess.digits.reverse
  w_result = white_pins.map.with_index { |a_code, index| a_code == black_pins[index] ? 1 : nil }
  b_result = black_pins.map { |b_code| white_pins.include?(b_code) ? 2 : nil }
  # binding.pry
  [w_result.compact.length, b_result.compact.length - w_result.compact.length]

  # [w_result, b_result]
end

def show_score(score)
  score[0].times { print "\e[37m ⬤" }
  score[1].times { print "\e[30m ⬤" }
end

# tenho dois resultados que dao em uma array, 1 para cada pino branco, 2 para cada pino preto. para calcular quantos
# pinos o usuario acertou, basta lembrar que os pretos tambem contam os brancos, e subtrair a quantia de pretos existentes
# pela quantidade de pinos brancos.

# game_intro
# game_start
# print(calculate_score(1214, 1413)) 
show_score([1, 2])


