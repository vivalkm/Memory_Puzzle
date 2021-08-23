class ComputerPlayer
    def initialize(size)
        @i = 0
        @visited_first = {}	# store the value:position pair if it's first time the value is seen
        @visited_second = {}	# store the value:position pair if it's second time the value is seen
        @locations = []		# store the board locations
        (0...size).each do |row|
            (0...size).each do |col|
                @locations << [row, col]
            end
        end
    end
    
    # When reveal a card, put position and card value into a hash
    def receive_revealed_card(pos, value)
        if @visited_first[value] == nil 
            @visited_first[value] = pos
        elsif @visited_first[value] != pos
            @visited_second[value] = pos
        end
    end
	
    # When complete a match, remove value:pos pair from both hashes
    def receive_match(pos, value)
        @visited_first.delete(value)
        @visited_second.delete(value)
    end

    def get_input(pre_value, pre_pos)
        if pre_value == []
            # On its first guess, if it knows where 2 matching cards are, guess one of them.
            if @visited_second.length > 0
                return @visited_second[@visited_second.keys[0]]
            else
                return unvisited_pos()
            end
        # On its second guess, if its first guess revealed a card whose value matches a known location
        # if the first card is in visited_second, then we need a match from visited_first
        # if the first card has a new value, then we keep visiting unvisited pos.
        else
            if @visited_second[pre_value] != nil 
                return @visited_first[pre_value]
            else
                return unvisited_pos()
            end
        end
    end

    # Each unvisited location will be visited once
    def unvisited_pos()
        pos = @locations[@i]
        @i += 1
        return pos
    end
end