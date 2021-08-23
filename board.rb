require_relative "card"

class Board
    def initialize(size)
        @size = size
        @card_values = []
        card_range = ("A".."Z").to_a
        while @card_values.length < (size * size / 2)
            @card_values += card_range.sample([card_range.length, size * size / 2 - @card_values.length].min)
        end
        @card_values *= 2
        @grid = Array.new(size) { Array.new(size) }
        @hidden = @size * @size
        populate()
    end
    
    # Fill the 2x2 metric with cards.
    def populate()
        @card_values.shuffle!
        i = 0
        (0...@size).each do |row|
            (0...@size).each do |col|
                @grid[row][col] = Card.new(@card_values[i])
                i += 1
            end
        end
    end

    def valid_pos?(pos)
        pos[0] >= 0 && pos[0] < @size && pos[1] >= 0 && pos[1] < @size
    end

    def card(pos)
        @grid[pos[0]][pos[1]]
    end

    # Print out the board.
    def render()
        print "  "
        (0...@size).each do |col|
            print (col).to_s + " "
        end
        puts

        (0...@size).each do |row|
            (-1...@size).each do |col|
                print col == -1 ? row : card([row, col]).display
                print " "
            end
            puts
        end
    end

    def flip(pos)
        if !card(pos).face_up
            card(pos).reveal
            @hidden -= 1
        else
            card(pos).hide
            @hidden += 1
        end
        return card(pos).value
    end

    def won?()
        @hidden == 0
    end

end