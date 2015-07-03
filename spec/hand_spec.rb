require 'rspec'
require 'hand'
require 'card'

# deal cards to hand from deck
# check if it beats another hand
  # find its strongest valid combo
  # if tied based on combo, then tiebreaker based on value/combo:
    # if high card, value of next highest card
    # if pair, value of next highest card
    # if two pair, value of highest pair/lowest pair/kicker
    # if three of a kind, value of next highest card
    # if straight, split pot
    # if flush, value of highest card
    # if full house, value of three of a kind
    # if straight flush, split pot


describe Hand do
  let(:deck) { double("deck") }
  subject(:hand) { Hand.new }
  # hand = [
  #   Card.new(:heart, :two)
  #   Card.new(:spade, :three)
  #   Card.new(:heart, :five)
  #   Card.new(:heart, :six)
  #   Card.new(:heart, :nine)
  #   ]

  describe "#initialize" do
    it "should deal five cards to the hand" do
      #allow(deck).to receive(:deal).and_return([hand])
      Hand.
      expect(Hand.deal_from(deck).).

    end
  end


  def self.deal_from(deck)
    Hand.new(deck.deal(5))
  end





end
