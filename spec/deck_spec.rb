require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }
  let(:card) { double("card") }
  let(:returned_cards) { [card] }

  it "initializes with 52 unique cards" do
    expect(deck.cards.uniq.count).to eq(52)
  end

  describe "#deal" do
    dealt_cards = []

    before(:each) do
      dealt_cards.concat(deck.deal(2))
    end

    it "removes card(s) when drawing from the deck" do
      expect(deck.count).to eq(50)
    end

    it "returns an array of dealt cards" do
      expect(dealt_cards.all? { |card| card.is_a?(Card) }).to be true
    end

    it "deals the right number of cards" do
      expect(dealt_cards.count).to eq(2)
    end
  end

  describe "#return" do

    it "adds the correct card to the bottom of the deck" do
      expect(deck.return(returned_cards).cards.last).to eq(card)
    end
  end

end
