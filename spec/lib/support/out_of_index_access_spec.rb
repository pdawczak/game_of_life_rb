require "spec_helper"
require_relative "../../../lib/support/out_of_index_access"

RSpec.describe OutOfIndexAccess do
  using OutOfIndexAccess

  describe NilClass do
    describe "#[]" do
      it "returns empty array" do
        expect(nil[1]).to eq []
      end
    end
  end

  describe Array do
    describe "#to_i" do
      it "returns 0" do
        expect([].to_i).to eq 0
      end
    end
  end
end
