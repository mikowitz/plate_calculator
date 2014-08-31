require "spec_helper"

describe PlateCalculator do
  # default values are a 45 lb bar and unlimited plates 1.25 - 45
  describe "with default values" do
    let(:calculator) { PlateCalculator.new }

    it "should return correct plates for possible weights" do
      expect(calculator.plates_for(45)).to match_array []
      expect(calculator.plates_for(100)).to match_array [25, 2.5]
      expect(calculator.plates_for(155)).to match_array [45, 10]
      expect(calculator.plates_for(205)).to match_array [45, 35]
      expect(calculator.plates_for(267.5)).to match_array [45, 45, 10, 10, 1.25]
    end

    it "should return a useful error message for impossible weights" do
      expect(calculator.plates_for(40)).to be_a Hash
      expect(calculator.plates_for(40)[:error]).to eq "You cannot load that weight with your current bar. Please use a lighter bar."

      expect(calculator.plates_for(46)).to be_a Hash
      expect(calculator.plates_for(46)[:error]).to eq "You cannot load that weight with your current plates. Please select a total weight divisible by 2.5"
    end
  end

  describe "with a non-default bar weight" do
    let(:calculator) { PlateCalculator.new(25) }

    it "should return correct plates for possible weights" do
      expect(calculator.plates_for(25)).to match_array []
      expect(calculator.plates_for(135)).to match_array [45, 10]
    end
  end

  describe "with limited plates" do
    let(:calculator) { PlateCalculator.new }
    before do
      calculator.set_plate_count(45, 1)
    end

    it "should return correct plates for possible weights" do
      expect(calculator.plates_for(225)).to match_array [45, 35, 10]
    end
  end
end
