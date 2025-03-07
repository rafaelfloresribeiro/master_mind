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
  when 5
    "\e[45m  5  \e[0m"
  when 6
    "\e[46m  6  \e[0m"
  end
end

def computer_code_generator
  # alpha = rand(1..6)
  # beta = rand(1..6)
  Array.new(4) { rand(1..6) }
  # [1, 1, 2, 2]
  # [alpha, alpha, beta, beta]
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

def new_calculate_score(guess, code)
  white_pin_tally = guess.map.with_index { |pegs, index| pegs == code[index] ? index : nil }
  black_pin_tally = guess.map.with_index { |pegs, index| code.include?(pegs) ? index : nil }
  [white_pin_tally.compact.length, black_pin_tally.compact.length - white_pin_tally.compact.length]
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
  first_guess = first_guess_generator
  computer_play_round_text(first_guess, player_code)
  computer_score = new_calculate_score(first_guess, player_code)
  possible_guess = all_codes
  next_guess, possible_guess = chinese_computer_code_breaker(first_guess, computer_score, possible_guess)
  computer_play_round_text(next_guess, player_code)
  computer_score = new_calculate_score(next_guess, player_code)
  round_counter = 0
  until computer_score == [4, 0]
    round_counter += 1
    print("Round number #{round_counter} \n")
    next_guess, possible_guess = chinese_computer_code_breaker(next_guess, computer_score, possible_guess)
    computer_play_round_text(next_guess, player_code)
    computer_score = new_calculate_score(next_guess, player_code)
  end
  print('Game Over')
end

def chinese_computer_code_breaker(last_computer_guess, feedback, possible_codes)
  possible_codes.select! do |code|
    new_calculate_score(last_computer_guess, code) == feedback
  end
  [possible_codes.sample, possible_codes]
end

def all_codes
  (1..6).to_a.repeated_permutation(4).to_a
end

def first_guess_generator
  first_digit = rand(1..6)
  second_digit = rand(1..6)
  second_digit = rand(1..6) until second_digit != first_digit
  [first_digit, first_digit, second_digit, second_digit]
end

def guessinator(exclude)
  possible_numbers = (1..6).to_a - exclude.flatten
  guess = possible_numbers.sample(2)
  [guess[0], guess[0], guess[1], guess[1]]
end

def computer_play_round_text(guess, code)
  print("The computer will now guess\n")
  sleep 1
  print("the computer guesses\n")
  display_code(guess)
  sleep 1
  print("the computer scores \n")
  computer_score = new_calculate_score(code, guess)
  print("#{show_score(computer_score)} \n")
  sleep 1
  computer_score == 'Game Over' ? print('The computer won') : nil
end

def guess_tracker(number_sequence)
  response = number_sequence.uniq
end

mode_selector('master')
