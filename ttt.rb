# Draw game board
# Loop 
# 	Player chooses empty square
# 	Check for winner
# 	Computer chooses empty square
# 	Check for winner
# until winner or all squares taken
# 	Print winner name or if tie

def initialize_board
	b = {}
	(1..9).each {|square| b[square] = ' '}
	b
end

def draw_board(b)
	puts " #{b[1]} | #{b[2]} | #{b[3]} "
	puts "----------"
	puts " #{b[4]} | #{b[5]} | #{b[6]} "
	puts "----------"
	puts " #{b[7]} | #{b[8]} | #{b[9]} "
end

def empty_squares(b)
	b.select {|k, v| b[k] == ' '
end

def player_choose(b)
	puts "Pick a square (1-9)"
	square = gets.chomp.to_i
	b[square] = 'X'
end

def computer_choose(b)
	square = empty_squares(b).sample
	b[square] = 'O'
end

board = initialize_board

# begin
	puts initialize_board
	draw_board(board)
	player_choose(board)
	computer_choose(board)
# end until winner || all squares taken
