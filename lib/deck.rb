require_relative 'card'

class Deck

  attr_reader :cards

  def create_deck
    cards = []
    Card::SUITS.each do |suit, _|
      Card::CARD_VALUE_STRINGS.each do |val, _|
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
