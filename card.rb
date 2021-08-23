class Card
    attr_reader :face_up, :value
    
    def initialize(value)
        @value = value
        @face_up = false
    end

    def hide()
        @face_up = false
    end
    
    def reveal()
        @face_up = true
    end

    def ==(other_card)
        self.value == other_card.value
    end

    def display()
        @face_up ? @value : " "
    end
end