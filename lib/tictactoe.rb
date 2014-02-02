class TicTacToe < ActiveRecord::Base
  attr_accessor :board
  
  WIN_LINES = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
    ]

  def initialize(board=nil)
    @board = board || [nil]*9
  end

  def winner
    WIN_LINES.each do |line|
      current_line = [ @board[line[0]], @board[line[1]], @board[line[2]] ]
      
      unless current_line.include?(nil)
        current_line.uniq.length == 1 ? (return line) : nil
      end
    end
    nil
  end

  def completed?
    winner || !board.include?(nil)
  end

  def move(location, value)
    if @board[location].nil?
      @board[location] = value
      completed?
    end
  end

end