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
    suits = [:clubs, :diamonds, :hearts, :spades]
    ranks = [:ace, 2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king]

    # Do a double for loop to go through create all the different cards.
    suits.each do |suit|
      ranks.each do |rank|
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
