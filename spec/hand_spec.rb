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
  hand = [
    Card.new(:heart, :two),
    Card.new(:spade, :three),
    Card.new(:heart, :five),
    Card.new(:heart, :six),
    Card.new(:heart, :nine)
    ]
  let(:straight_flush) { Hand.new([
    Card.new(:heart, :two),
    Card.new(:heart, :three),
    Card.new(:heart, :four),
    Card.new(:heart, :six),
    Card.new(:heart, :five)
    ]) }
  let(:four_of_a_kind) { Hand.new([
    Card.new(:heart, :three),
    Card.new(:diamond, :three),
    Card.new(:spade, :three),
    Card.new(:club, :three),
    Card.new(:heart, :five)
    ]) }
  let(:full_house) { Hand.new([
    Card.new(:heart, :three),
    Card.new(:diamond, :three),
    Card.new(:spade, :three),
    Card.new(:club, :five),
    Card.new(:heart, :five)
    ]) }
  let(:flush) { Hand.new([
    Card.new(:heart, :two),
    Card.new(:heart, :three),
    Card.new(:heart, :four),
    Card.new(:heart, :seven),
    Card.new(:heart, :five)
    ]) }
  let(:straight) { Hand.new([
    Card.new(:heart, :two),
    Card.new(:heart, :three),
    Card.new(:heart, :four),
    Card.new(:diamond, :six),
    Card.new(:heart, :five)
    ]) }
  let(:three_of_a_kind) { Hand.new([
    Card.new(:heart, :two),
    Card.new(:spade, :two),
    Card.new(:heart, :four),
    Card.new(:diamond, :two),
    Card.new(:heart, :five)
    ]) }
  let(:two_pair { Hand.new([
    Card.new(:heart, :two),
    Card.new(:diamond, :two),
    Card.new(:club, :six),
    Card.new(:diamond, :six),
    Card.new(:heart, :five)
    ]) }
  let(:pair) { Hand.new([
    Card.new(:heart, :two),
    Card.new(:heart, :three),
    Card.new(:heart, :four),
    Card.new(:diamond, :two),
    Card.new(:heart, :five)
    ]) }

  describe "#deal_from" do
    it "should deal five cards to the hand" do
      allow(deck).to receive(:deal(5)).and_return(hand)
      test_hand = Hand.deal_from(deck)
      expect(test_hand.cards.length).to eq(5)
    end
  end

  describe "#combo?" do
    it "returns true if there's a combo" do
      expect(pair).to be_combo
    end

    it "doesn't return false positives" do
      expect(hand).not_to be_combo
    end
  end

  describe "#determine_combo_value" do
    it "should return 8 for a straight flush" do
      expect(straight_flush.determine_combo_value).to eq(8)
    end
    it "should return 7 for a four of a kind" do
      expect(four_of_a_kind.determine_combo_value).to eq(7)
    end
    it "should return 6 for a full house" do
      expect(full_house.determine_combo_value).to eq(6)
    end
    it "should return 5 for a flush" do
      expect(flush.determine_combo_value).to eq(5)
    end
    it "should return 4 for a straight" do
      expect(straight.determine_combo_value).to eq(4)
    end
    it "should return 3 for a three of a kind" do
      expect(three_of_a_kind.determine_combo_value).to eq(3)
    end
    it "should return 2 for a two pair" do
      expect(two_pair.determine_combo_value).to eq(2)
    end
    it "should return 1 for a pair" do
      expect(pair.determine_combo_value).to eq(1)
    end
  end

  describe "#best_combo" do
    describe "should prioritize better combos" do
      it "knows a full house is better than a 3 of a kind" do
        expect(full_house.best_combo).to eq(:full_house)
      end

      it "knows a straight flush is better than a straight or flush" do
        expect(straight_flush.best_combo).to eq(:straight_flush)
      end

      it "knows a 2 pair is better than a pair" do
        expect(two_pair.best_combo).to eq (:two_pair)
      end
    end
  end




  end

  describe "#value" do
    it "should correctly return the sum of the cards" do
      expect(hand.value).to eq(25)
    end
  end






end
