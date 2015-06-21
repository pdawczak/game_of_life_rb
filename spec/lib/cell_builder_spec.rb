require "spec_helper"
require_relative "../../lib/map"
require_relative "../../lib/cell_builder"

RSpec.describe CellBuilder do
  let(:map) do
    Map.new([ [1, 0, 0, 0],
              [0, 1, 0, 0],
              [0, 0, 1, 0],
              [0, 0, 0, 0] ])
  end

  describe ".build_for" do
    it "returns a cell" do
      expect(CellBuilder.build_for(map, 1, 1)).to be_kind_of Cell
    end
  end

  describe "#cell_state" do
    it "equals the value at specified point" do
      preparator = CellBuilder.new(map, 2, 2)
      expect(preparator.cell_state).to eq 1
    end
  end

  describe "#neighbour_states" do
    it "returns values of neighbours" do
      preparator = CellBuilder.new(map, 2, 2)
      expect(preparator.neighbour_states.count { |state| state == 1 }).to eq 1
    end
  end
end
