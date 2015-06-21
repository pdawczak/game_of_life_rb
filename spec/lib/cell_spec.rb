require "spec_helper"
require_relative "../../lib/cell"

RSpec.describe Cell do
  let(:cell) { Cell.new(1, [1, 0, 1]) }
  subject    { cell }

  it { is_expected.to respond_to :current_state }
  it { is_expected.to respond_to :neighbours }

  describe "#count_of_live_neighbours" do
    it "counts live neighbours" do
      expect(cell.count_of_live_neighbours).to eq 2
    end
  end

  describe "#next_state" do
    context "current state is 0" do
      context "and has count of live neighbours != 3" do
        it "should remain 0" do
          expect(Cell.new(0, [0]).next_state).to eq 0
        end
      end

      context "and ah count of live neghbours == 3" do
        it "should become 1" do
          expect(Cell.new(0, [1, 1, 1]).next_state).to eq 1
        end
      end
    end

    context "if current state is 1" do
      context "and has count of live neighbours less than 2 or more than 3" do
        it "should become 0" do
          expect(Cell.new(1, [1]).next_state).to eq 0
          expect(Cell.new(1, [1, 1, 1, 1]).next_state).to eq 0
        end
      end

      context "and has count of live neighbours equal 2 or equal 3" do
        it "should remain 1" do
          expect(Cell.new(1, [1, 1]).next_state).to eq 1
          expect(Cell.new(1, [1, 1, 1]).next_state).to eq 1
        end
      end
    end
  end
end
