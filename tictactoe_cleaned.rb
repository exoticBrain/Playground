module Tools
  def new_line
    puts
  end

  def clear_screen
    system "clear"
  end
end

class Game
  def start
    initialize_the_game
    loop do
      board.display
      human.choose(board.board)
      computer.choose(board.board)

      break if board.winner? || board.full?
    end

    board.display
    board.display_winner

    play_again? do
      board.initialize_board_list
      start
    end
  end
  
  private

  attr_accessor :human, :computer, :board
  
  MARKER = ['X', 'O']

  def initialize_the_game
    player_marker, computer_marker = MARKER.shuffle
    self.human = Human.new(player_marker, "Tariq")
    self.computer = Computer.new(computer_marker)
    self.board = Board.new(human, computer)
  end

  def play_again?
    puts "Do you wanna play again? (Y/N)"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "You must choose only 'Y' or 'N'"
    end
    if answer == 'y'
      yield
    else
      puts "--------Thank you for playing Tic Tac Toe.--------"
    end
  end
end


class Board
  include Tools
  attr_accessor :board
  attr_reader :player, :computer

  def initialize(player, computer)
    self.board = {}
    initialize_board_list
    @player = player
    @computer = computer
  end

  def display
    clear_screen
    info
    new_line
    puts "       |       |"
    puts "       |       |"
    puts "   #{board[1]}   |   #{board[2]}   |   #{board[3]}"
    puts "       |       |"
    puts "       |       |"
    puts "-------+-------+-------"
    puts "       |       |"
    puts "       |       |"
    puts "   #{board[4]}   |   #{board[5]}   |   #{board[6]}"
    puts "       |       |"
    puts "       |       |"
    puts "-------+-------+-------"
    puts "       |       |"
    puts "       |       |"
    puts "   #{board[7]}   |   #{board[8]}   |   #{board[9]}"
    puts "       |       |"
    puts "       |       |"
    new_line
  end

  def winner?
    !!detect_winner
  end

  def full?
    empty_squares.empty?
  end

  def display_winner
    if player.won
      puts "#{player.name} won the game"
    elsif computer.won
      puts "#{computer.name} won the game"
    else
      puts "It's a tie"
    end
    new_line
  end

  def initialize_board_list
    (1..9).each { |num| self.board[num] = INITIAL_MARKER }
  end

  private
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
  INITIAL_MARKER = ' '

  def info
    new_line
    print "-------- #{player.name} is '#{player.marker}' and"
    print " #{computer.name} is '#{computer.marker}' --------"
    new_line
  end

  def empty_squares
    board.keys.select { |num| board[num] == ' ' }
  end

  def detect_winner
    WINNING_LINES.each do |line|
      if board.values_at(*line).count(player.marker) == 3
        player.won = true
        return true
      elsif board.values_at(*line).count(computer.marker) == 3
        computer.won = true
        return true
      end
    end
    false
  end
end

class Player
  attr_accessor :won, :choice
  attr_reader :marker, :name

  def initialize(marker, name = NAMES.sample)
    @marker = marker
    @name = name
    @won = false
  end

  def choose(board)
    square = choose_square(board)
    board[square] = marker
  end

  private

  NAMES = ['R@D2', 'LI@X', 'M-A&3']

  def empty_squares(board)
    board.keys.select { |num| board[num] == ' ' }
  end
end

class Human < Player
  attr_accessor :name

  def name=(name)
    @name = name
  end

  private

  def choose_square(board)
    answer = nil
    puts "Choose a square from : #{joinor(empty_squares(board))}"
    loop do
      print '>> '
      answer = gets.chomp.to_i
      break if (1..9).cover?(answer) && board[answer] == ' '
      puts "INVALID!!"
    end
    answer
  end

  def joinor(arr, delimiter = ', ', linker = 'or')
    joined_string = ''
  
    if arr.size == 2
      joined_string << arr[0].to_s + ' ' + linker + ' ' + arr[1].to_s
    elsif arr.size == 1
      joined_string << arr[0].to_s
    else
      arr.each_with_index do |number, index|
        if index == arr.size - 1
          joined_string << linker + ' ' + number.to_s
        else
          joined_string << number.to_s + delimiter
        end
      end
    end
  
    joined_string
  end
end

class Computer < Player

  def choose_square(board)
    board.select { |_, square| square == ' ' }.keys.sample
  end
end

Game.new.start