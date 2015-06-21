require "spec_helper"
require_relative "../../lib/map"

RSpec.describe Map do
  let(:map) { Map.parse(string_map) }

  describe "simple scenario" do
    context "block" do
      let(:string_map) do
<<EOM.strip
0000
0110
0110
0000
EOM
      end

      it "is not changed" do
        map.tick
        expect(map.to_s).to eq string_map
      end
    end

    context "blinker" do
      let(:string_map) do
<<EOM.strip
00000
00100
00100
00100
00000
EOM
      end

      let(:expected_map) do
<<EOM.strip
00000
00000
01110
00000
00000
EOM
      end

      it "illustrates 'Oscilator'" do
        map.tick
        expect(map.to_s).to eq expected_map
      end
    end
  end

  describe "#at" do
    it "accesses value at specified point" do
      map = Map.new([ [0, 1],
                      [1, 0] ])
      expect(map.at(0, 1)).to eq 1
      expect(map.at(1, 1)).to eq 0
    end

    it "indicates 0's when accessing value 'outside' of map" do
      map = Map.new([ [0, 1],
                      [1, 0] ])

      expect(map.at(-1, 0)).to eq 0
      expect(map.at(0, -1)).to eq 0
      expect(map.at(0, 2)).to eq 0
      expect(map.at(2, 0)).to eq 0
    end
  end
end
