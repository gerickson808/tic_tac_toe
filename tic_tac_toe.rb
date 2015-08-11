class Player
	attr_reader :sign

	def initialize (sign)
		@sign = sign
	end

end

class Board
	attr_accessor :spaces

	@@acceptable_moves = ["top left", "top center", "top right", "center left",
												"center", "center right", "bottom left", "bottom center",
												"bottom right"]

	def initialize
		@player1 = Player.new("X")
		@player2 = Player.new("O")
		@spaces = Array.new(0)
		3.times {@spaces << [" ", " ", " "]}
		@turn = 1
		turn
	end

private

	def turn
		tie_game if @turn == 10
		@player = @turn%2 == 1 ? @player1 : @player2
		display_name = @player == @player1 ? "Player 1" : "Player 2"
		puts "#{display_name}: Choose your space. Enter 'help' for options."
		choice
	end

	def choice
		choice = gets.chomp
		if @@acceptable_moves.include? choice
			move(choice)
			display_board
			check_if_win
		elsif choice == "help"
			help
		else
			puts "Invalid selection, let's try again."
			turn
		end
	end

	def move(choice)
		space = @@acceptable_moves.index(choice)
		i = space / 3
		j = space%3
		unless @spaces[i][j] == " "
			turn
		end
		@spaces[i][j] = @player.sign




	end

	def display_board
		q = @spaces
		puts " #{q[0][0]} | #{q[0][1]} |  #{q[0][2]} "
		puts "-----------"
		puts " #{q[1][0]} | #{q[1][1]} |  #{q[1][2]} "
		puts "-----------"
		puts " #{q[2][0]} | #{q[2][1]} |  #{q[2][2]} "

	end

	def check_if_win
		0.upto(2) do |i| 
			win if @spaces[i].all? {|sign| sign == @player.sign}
			counter = 0
			0.upto(2) do |j| #for this section, i and j are used opposite of normal
				counter += 1 if @spaces[j][i] == @player.sign
			end
			win if counter == 3
		end

		if @spaces[0][0] == @spaces[1][1] && @spaces[0][0] == @spaces[2][2]
			win unless @spaces[0][0] == " "
		end

		if @spaces[0][2] == @spaces[1][1] && @spaces[0][2] == @spaces[2][0]
			win unless @spaces[0][2] == " "
		end

		next_turn
	end

	def win
		display_name = @player == @player1 ? "Player 1" : "Player 2"
		puts "#{display_name} wins!"
		new_game?
	end

	def next_turn
		@turn += 1
		turn
	end

	def help
		puts "The object is to get three in a row. On your turn,"
		puts "choose an unoccupied space."
		puts "Options are:"
		puts "top left,     top center,    top right"
		puts "center left,  center,        center right"
		puts "bottom left,  bottom center, bottom right"
		turn
	end

	def new_game?
		puts "New game? (y/n)"
		new_game = gets.chomp
		new_game == "y" ? initialize : exit
	end

	def tie_game
		puts "Tie game! Try harder!"
		new_game?
	end


end

board = Board.new