require 'rspec'
require 'array'
require 'byebug'


describe "array exercises" do
  describe "#my_uniq" do

    context "handles an empty array" do
      let(:empty_array) { [] }

      it "returns an empty array" do
        expect(empty_array.my_uniq).to eq([])
      end
    end

    context "handles an already uniq'd array" do
      let(:uniq_array) { [1, 2, 3] }

      it "does not modify the array" do
        expect(uniq_array.my_uniq).to eq(uniq_array)
      end
    end

    context "returns unique values of an array with repeated values" do
      let(:array) { [1, 2, 2, 3, 4, 5, 5]}

      it "returns an array of unique values" do
        expect(array.my_uniq).to eq([1, 2, 3, 4, 5])
      end
    end
  end

  describe "#two_sum" do

    context "handles an empty array" do
      let(:empty_array) { [] }

      it "returns nil" do
        expect(empty_array.two_sum).to be_nil
      end
    end

    context "handles an array with no matches" do
      let(:array) { [1, 3, 3, -2] }

      it "returns nil" do
        expect(array.two_sum).to be_nil
      end
    end

    context "handles one pair that sums to zero" do
      let(:array) { [1, 2, -1, 0] }

      it "returns an empty array" do
        expect(array.two_sum).to eq([[0, 2]])
      end
    end

    context "returns index pairs in order" do
      let(:array) { [-1, 0, 2, -2, 1] }

      it "returns an empty array" do
        expect(array.two_sum).to eq([[0, 4], [2, 3]])
      end
    end
  end

  describe "#median" do

    context "handles an empty array" do
      let(:empty_array) { [] }

      it "returns nil" do
        expect(empty_array.median).to be_nil
      end
    end

    context "handles a sorted array" do
      let(:array) { [1, 2, 2, 3, 4] }
      # byebug
      it "returns the median" do
        expect(array.median).to eq(2)
      end
    end

    it "handles an unsorted array" do
      array = [5, 3, 2, 4, 0]
      expect(array.median).to eq(3)
    end

    context "returns the correct value for an even length array" do
      let(:array) { [1, 2, 4, 5] }

      it "returns the average of the middle two numbers" do
        expect(array.median).to eq(3)
      end
    end
  end

  describe "#my_transpose" do
    context "handles an empty matrix" do
      let(:matrix) { [[]] }

      it "returns the empty matrix" do
        expect(matrix.my_transpose).to eq([[]])
      end
    end

    context "returns nil if not given a matrix" do
      let(:bad_matrix) { [[1, 2, 3], [4, 5]]}

      it "returns nil for a non-matrix 2D array" do
        expect(bad_matrix.my_transpose).to be_nil
      end
    end

    context "transposes a square matrix" do
      let(:matrix) { [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }

      it "returns the transposed matrix" do
        expect(matrix.my_transpose).to eq([[1, 4, 7], [2, 5, 8], [3, 6, 9]])
      end
    end

    it "transposes a rectangular matrix" do
      matrix = [[1, 2], [3, 4], [5, 6]]
      expect(matrix.my_transpose).to eq([[1, 3, 5], [2, 4, 6]])
    end
  end
end
