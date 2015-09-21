class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]   
  end
   
  def start_game
    players
    markers
    print_board
    play
  end
 
  def print_board
    puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
  end
 
  def players
    puts "Welcome to my Tic Tac Toe game! What is your name?"
      hum_name = gets.chomp.capitalize!
    puts "Hello, #{hum_name}! Would you like to go first (yes/no)?"
      @hum_first = gets.chomp.upcase!
  end

  def markers
    puts "Great! Which marker would you like to use (it can be X, O, or whatever symbol you'd like)?"
      @hum = gets.chomp
    puts "Which marker would you like the computer to use?"
      @com = gets.chomp
  end

  def play
    if @hum_first == "NO"
      com_move = rand(9)
      @board[com_move] = @com
      puts "The computer selected #{com_move}"
    end
    puts "Please select your spot."
    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      print_board
    end
    puts "Game is over."
  end
 
  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
        puts "The computer selected #{spot}"
      else
        spot = get_com_spot(@board, @com)
        if @board[spot] != @hum && @board[spot] != @com
          @board[spot] = @com
          puts "The computer selected #{spot}"
        else
          spot = nil
        end
      end
    end
  end
 
  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if @board[spot] != @hum && @board[spot] != @com
        @board[spot] = @hum
        puts "You selected #{spot}"
      else
        spot = nil
      end
    end
  end
  
   def get_com_spot(best_move, available_spaces)
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end
  
  def best_move(board, depth = 0)
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
  end
  
  def available_spaces(board, depth = 0)
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != @hum && s != @com
        available_spaces << s
      end
    end
  end
  
  def game_is_over(b)
  
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == @hum || s == @com }
  end
  
end

game = Game.new
game.start_game
