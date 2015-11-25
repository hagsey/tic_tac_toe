WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], 
                [1, 4, 7], [2, 5, 8], [3, 6, 9], 
                [1, 5, 9], [3, 5, 7]]

PLAYER_MARKER = 'X'
COMPUTER_MARKER = '0'
INITIAL_MARKER = ' '

def initialize_board
  board = {}
  (1..9).each { |square| board[square] = ' ' }
  board
end

def draw_board(b)
  system 'clear'
  puts "TIC, TAC, T0E"
  puts " #{b[1]} | #{b[2]} | #{b[3]} "
  puts "----------"
  puts " #{b[4]} | #{b[5]} | #{b[6]} "
  puts "----------"
  puts " #{b[7]} | #{b[8]} | #{b[9]} "
end

def empty_squares(board)
  board.keys.select { |square| board[square] == ' ' }
end

def winner_check(board)
  WINNING_LINES.each do |line|
    return "Player" if board.values_at(*line).count('X') == 3
    return "Computer" if board.values_at(*line).count('O') == 3
  end
  nil
end

def player_choice(board)
  begin
    puts "Select an empty square: (#{empty_squares(board).join(', ')})."
    square = gets.chomp.to_i
  end until empty_squares(board).include?(square)
  board[square] = 'X'
end

def find_at_risk_square(line, board, mark)
  if board.values_at(*line).count('X') == 2
    board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  else
    nil
  end
end

def computer_choice(board)
  square = nil

  # defense first
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, board, PLAYER_MARKER)
    break if square
  end

  # offense
  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, board, COMPUTER_MARKER)
      break if square
    end
  end

  # just pick a square
  if !square
    square = empty_squares(board).sample
  end

  board[square] = COMPUTER_MARKER
end

loop do
  board = initialize_board
  draw_board(board)
  begin
    player_choice(board)
    draw_board(board)
    break if winner = winner_check(board)
    puts "Computer is thinking..."
    sleep 1
    computer_choice(board)
    draw_board(board)
    winner = winner_check(board)
  end until winner || empty_squares(board).empty?
  if winner
    puts "#{winner} won!"
  else
    puts "It's a tie!"
  end
  sleep 1
  puts "Play again? (Y/N)"
  play_again = gets.chomp.upcase
  break unless play_again == 'Y'
end