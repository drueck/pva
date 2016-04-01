RSpec.describe Pva::SetResult do
  describe "#winner" do
    context "if home > visitor" do
      it "returns :home" do
        set_result = Pva::SetResult.new(set: 1, home: 25, visitor: 24)
        expect(set_result.winner).to eq :home
      end
    end
    context "if visitor > home" do
      it "returns :visitor" do
        set_result = Pva::SetResult.new(set: 1, home: 24, visitor: 25)
        expect(set_result.winner).to eq :visitor
      end
    end
    context "if home == visitor" do
      it "returns :tie" do
        set_result = Pva::SetResult.new(set: 1, home: 25, visitor: 25)
        expect(set_result.winner).to eq :tie
      end
    end
  end

  describe "#loser" do
    context "if home > visitor" do
      it "returns :visitor" do
        set_result = Pva::SetResult.new(set: 2, home: 25, visitor: 22)
        expect(set_result.loser).to eq :visitor
      end
    end
    context "if visitor > home" do
      it "returns :home" do
        set_result = Pva::SetResult.new(set: 2, home: 22, visitor: 25)
        expect(set_result.loser).to eq :home
      end
    end
    context "if home == visitor" do
      it "returns :tie" do
        set_result = Pva::SetResult.new(set: 3, home: 10, visitor: 10)
        expect(set_result.loser).to eq :tie
      end
    end
  end
end
