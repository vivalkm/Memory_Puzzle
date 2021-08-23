class HumanPlayer
    def get_input(pre_value, pre_pos)
        puts "Please input a position to show card. e.g. '1 2'"
        print ">> "
        return gets().split(" ")
    end

    def initialize(size)
    end

    def receive_revealed_card(pos, value)
    end

    def receive_match(pos, value)
    end
end