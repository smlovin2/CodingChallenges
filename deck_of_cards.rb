class Card
  attr_accessor :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def output_card
    puts "#{self.rank} of #{self.suit}"
  end
end

class Deck
  def initialize
    # Create an array that holds all the different cards
    @cards = []

    # Do a double for loop to go through create all the different cards.
    # The first loop will take care of the suit while the second will take
    # care of the rank.
    for i in 1..4
      for j in 1..13
        # We assign a number to the different suits
        case i
        when 1
          suit = :clubs
        when 2
          suit = :diamonds
        when 3
          suit = :hearts
        when 4
          suit = :spades
        end

        # We also need to take care of the special cases for the rank
        case j
        when 1
          rank = :ace
        when 11
          rank = :jack
        when 12
          rank = :queen
        when 13
          rank = :king
        else
          rank = j
        end

        # Now we create the card and add it to our array
        @cards << Card.new(rank, suit)
      end
    end

  end

  def shuffle
    @cards.shuffle!
  end

  def deal
    return @cards.shift
  end

  def output
    @cards.each do |card|
      card.output_card
    end
  end

  def size
    return @cards.length
  end
end

deck = Deck.new
puts "Initial Deck:"
deck.output
puts
puts "Deck after being shuffled:"
deck.shuffle
deck.output
puts
puts "Dealing a card:"
puts deck.deal.output_card
puts
puts "Size of deck after deal:"
puts deck.size
