require_relative 'card'

class Deck

  attr_reader :cards

  def create_deck
    cards = []
    Card::SUITS.keys.each do |suit|
      Card::CARD_VALUE_STRINGS.keys.each do |val|
        cards << Card.new(suit, val)
      end
    end
    cards
  end

  def initialize
    @cards = create_deck
  end

  def deal(n)
    dealt_cards = []
    dealt_cards.concat(@cards.shift(n))
  end

  def return(cards_to_return)
    cards_to_return.each do |card|
      @cards << card
    end
  end


end
