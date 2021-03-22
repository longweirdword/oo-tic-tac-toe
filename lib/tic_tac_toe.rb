require "pry"
class TicTacToe
    attr_accessor :board 

    WIN_COMBINATIONS = [
        [0,1,2], 
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

def initialize 
    @board = Array.new(9, " ")
end 

def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1 
  end 


def move(index, token = "X")
    @board[index] = token 
end

def position_taken?(index)
    @board[index] != " "  
end 

def valid_move?(index)
    index.between?(0,8) && !position_taken?(index) 
end 

def turn_count 
    @board.count{|token| token == "X" || token == "O"}
end 

def current_player
    turn_count.even? ? "X" : "O"
end 


def turn 
    puts "Please enter 1-9:"
    input = gets.chomp 
    index = input_to_index(input)
    if  valid_move?(index)
        token = current_player 
        move(index, token) 
        display_board
    else 
        turn 
    end 
end 

def won?
    @x_tally = []
    @o_tally = []
    @board.each_with_index do |token, index|
        if token == "X"
            @x_tally << index 
        elsif token == "O"
            @o_tally << index 
        end 
    end 
    WIN_COMBINATIONS.detect do |combo| 
     @x_tally & combo == combo || @o_tally & combo == combo 
    end 
end 

def full? 
    @board.all?{|token| token == "X" || token == "O"}
end 

def draw? 
    !won? && full? 
end 

def over? 
    won? || draw?  
end 

def winner
    if won?
        @x_tally.length > @o_tally.length ? "X" : "O"
    end 
end 

def play 
    while !over? 
        turn 
    end 
    if won? 
        puts "Congratulations #{winner}!"
    elsif draw? 
        puts "Cat's Game!"
    end 
end 

end 