
require_relative '../lib/tic_tac_toe.rb'

class TicTacToe

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, current_player = "X")
        @board[index] = current_player
    end

    def position_taken?(index)
        !(@board[index].nil? || @board[index] == " ")
    end

    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def turn_count
        turn = 0
        @board.each do |index|
          if index == "X" || index == "O"
            turn += 1
          end
        end
        return turn
    end

    def current_player
        #if the turn count is an even number, that means O just went, so the next/current player is X
        num_turns = turn_count
        if num_turns % 2 == 0
          player = "X"
        else
          player = "O"
        end
        return player
    end

      def turn
        puts "Please choose a number 1-9:"
        user_input = gets.chomp
        index = input_to_index(user_input)
        if valid_move?(index)
          player_token = current_player
          move(index, player_token)
          display_board
        else
          turn
        end
      end

      def won?
        WIN_COMBINATIONS.each do |combo|
          w_index_1 = combo[0]
          w_index_2 = combo[1]
          w_index_3 = combo[2]
        
          position_1 = @board[w_index_1]
          position_2 = @board[w_index_2]
          position_3 = @board[w_index_3]
        
          if position_1 == position_2 &&
            position_2 == position_3 &&
            position_1 != " "
            return combo
          elsif @board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
            return false
          end
        end
        return false
      end

      def full?
        array = []
          @board.each do |add|
          if add != " "
            array << add
          end
        end
        if array.length < 9
          return false
        else
          return true
        end
      end
      
      def draw?
        if !won? && full?
          return true
        else
          return false
        end
      end

      def over?
        if won? || draw?
          return true
        else
          return false
        end
      end

      def winner
        index = []
        index = won?
        if index == false
          return nil
        else
          if @board[index[0]] == "X"
            return "X"
          else
            return "O"
          end
        end
      end

      def play
        until over? == true
          turn
        end
      
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
      end
end

