WIN_COMBINATIONS = [		
		[0,1,2],
		[3,4,5],
		[6,7,8],
		[0,4,8],
		[6,4,2],
		[0,3,6],
		[1,4,7],
		[2,5,8],
	]
	
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i-1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  board[index] != " " && board[index] !="" 
end

def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board,index)
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  #use turn_count to determine x or o turn_count
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
  #ask for user move
  puts "Please enter 1-9"
  #receive user input
  input = gets.strip
  #convert user input to index
  user_converted = input_to_index(input)
  #if valid_move, make move and show board
  if !valid_move?(board, user_converted)
    turn(board)
  #otherwise ask recall turn() until valid move is received
  end
  #token different? x or o how to tell
  move(board, user_converted, current_player(board))
  display_board(board)
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combos|
    position_1 = board[win_combos[0]]
    position_2 = board[win_combos[1]]
    position_3 = board[win_combos[2]]
    
    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
		  return win_combos
		elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
		  return win_combos
		end
		false
  end
  false
end

def full?(board)
  #return true every element in board contains x or o
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  #return true if the board has not been won, is full
  !won?(board) && full?(board)
  #false if the board is not won and board is not full
  #false board is won
end

def over?(board)
  #true if board is won, draw or full
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if win_array = won?(board)
    return board[win_array[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
     if won?(board) 
      puts "Congratulations " +winner(board)+ "!"
    elsif draw?(board)
      puts "Cat's Game!"
  end
end




