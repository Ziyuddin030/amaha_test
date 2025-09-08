require "rails_helper"

RSpec.describe HaversineService do
  describe ".distance" do
    it "returns 0 for identical points" do
      d = described_class.distance(19.0, 72.0, 19.0, 72.0)
      expect(d).to be_within(1e-9).of(0.0)
    end

    it "computes a known approximate distance" do
      d = described_class.distance(19.0590317, 72.7553452, 18.5204, 73.8567)
      expect(d).to be_between(120, 160)
    end
  end
end
