require 'rspec'
require 'card'

describe Card do
  let(:card) { Card.new(:heart, :ace) }

  it "should initialize with suit and card value" do
    expect(card.card_value).to eq("A")
    expect(card.suit).to eq('♡')
  end

  it "should have a numeric value" do
    expect(card.poker_value).to be(14)
  end
end
