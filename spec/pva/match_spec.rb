RSpec.describe Pva::Match do
  describe "#add_set_result" do
    it "adds the given set result to the set_results array" do
      match = Pva::Match.new(time: "1/1/2016 8:00pm",
                        home: "Mo Diggity",
                        visitor: "Court Jesters",
                        location: "PCC Sylvania",
                        division: "Coed A Thursday Doubleheaders")
      set1 = Pva::SetResult.new(set: 1, home: 22, visitor: 25)
      match.add_set_result(set1)
      expect(match.set_results).to include(set1)
    end
  end

  describe "#results_for(team)" do
    context "if the given team was one of teams in the match" do
      it "returns a MatchResults instance from the perspective of the given team" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        set1 = Pva::SetResult.new(set: 1, home: 22, visitor: 25)
        match.add_set_result(set1)
        results = match.results_for("Court Jesters")
        expect(results).to be_a(Pva::MatchResults)
        expect(results.team).to eq "Court Jesters"
        expect(results.opponent).to eq "Mo Diggity"
      end
    end
    context "if the given team was not one of the teams in the match" do
      it "returns nil" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        set1 = Pva::SetResult.new(set: 1, home: 22, visitor: 25)
        match.add_set_result(set1)
        results = match.results_for("Yo Diggity Dog")
        expect(results).to be_nil
      end
    end
  end
end
