require_relative "board"
require_relative "human_player"
require_relative "computer_player"

class Game
    def initialize()
        puts "Select mode: 1 for human player, 0 for AI player."
        @type = gets()[0].to_i
        puts "Select board size: 2 for easiest, and 10 for hardest."
        # Convert the input to odd number in range (2..10).
        size = [[2, gets().split()[0].to_i].max, 10].min / 2 * 2
        @board = Board.new(size || 4)
        @player = @type == 1 ? HumanPlayer.new(size) : ComputerPlayer.new(size)
        @prev_pos = []
        @prev_value = []
        @count = 0
    end

    def play()
        while !@board.won?()
            @count += 1
            pos = get_pos()
            cur_value = @board.flip(pos)
            if @prev_pos.length == 0
                @player.receive_revealed_card(pos, cur_value)
                @prev_pos = pos
                @prev_value = cur_value
            elsif @prev_value != cur_value
                system("clear")
                @board.render
                sleep(1) if @type == 1
                @player.receive_revealed_card(pos, cur_value)
                @board.flip(pos)
                @board.flip(@prev_pos)
                clear_prev_pos()
            else
                @player.receive_match(pos, cur_value)
                @player.receive_match(@prev_pos, @prev_value)
                clear_prev_pos()
            end
        end
        system("clear")
        @board.render
        puts "You win in #{@count} guesses!"
    end

    def clear_prev_pos()
        @prev_pos = []
        @prev_value = []
    end

    # Returns a two-item array containing a valid position to reveal a card
    def get_pos()
        valid_pos = false
        while !valid_pos
            system("clear")
            @board.render
            valid_pos = true
            pos = @player.get_input(@prev_value, @prev_pos)
            if pos.length != 2 || pos[0].to_s != pos[0].to_i.to_s || pos[1].to_s != pos[1].to_i.to_s
                valid_pos = false
            else
                pos[0], pos[1] = pos[0].to_i, pos[1].to_i
                if !@board.valid_pos?(pos) || @board.card(pos).face_up
                    valid_pos = false
                end
            end
        end
        return pos
    end
end

g = Game.new()
g.play()