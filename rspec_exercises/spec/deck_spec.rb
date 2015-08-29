require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }
  let(:card) { double("card") }
  let(:returned_cards) { [card] }
  let(:dealt_cards) { [] }

  it "initializes with 52 cards" do
    expect(deck.cards.count).to eq(52)
  end

  describe "#deal" do
    before(:each) do
      dealt_cards.concat(deck.deal(2))
    end

    it "removes card(s) when drawing from the deck" do
      expect(deck.cards.length).to eq(50)
    end

    it "returns an array of dealt cards" do
      # expect(dealt_cards).to all ( be_a(Card) )
      expect(dealt_cards.all? { |card| card.is_a?(Card) }).to be true
    end

    it "deals the right number of cards" do
      expect(dealt_cards.length).to eq(2)
    end
  end

  describe "#return" do
    it "adds the correct card to the bottom of the deck" do
      deck.return(returned_cards)
      expect(deck.cards.last).to eq(card)
    end
  end

end
