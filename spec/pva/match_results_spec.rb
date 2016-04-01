RSpec.describe Pva::MatchResults do
  describe "#team" do
    it "returns the name of the team from whose perspective the results are" do
      match = Pva::Match.new(time: "1/1/2016 8:00pm",
                             home: "Mo Diggity",
                             visitor: "Court Jesters",
                             location: "PCC Sylvania",
                             division: "Coed A Thursday Doubleheaders")
      expect(match.results_for("Court Jesters").team).to eq "Court Jesters"
      expect(match.results_for("Mo Diggity").team).to eq "Mo Diggity"
    end
  end

  describe "#opponent" do
    it "returns the name of the other team" do
      match = Pva::Match.new(time: "1/1/2016 8:00pm",
                             home: "Mo Diggity",
                             visitor: "Court Jesters",
                             location: "PCC Sylvania",
                             division: "Coed A Thursday Doubleheaders")
      expect(match.results_for("Court Jesters").opponent).to eq "Mo Diggity"
      expect(match.results_for("Mo Diggity").opponent).to eq "Court Jesters"
    end
  end

  describe "#result" do
    context "if the team beat the opponent in sets won" do
      it "returns W" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        match.add_set_result(Pva::SetResult.new(set: 1, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 2, home: 25, visitor: 22))
        match.add_set_result(Pva::SetResult.new(set: 3, home: 8, visitor: 15))
        results = match.results_for("Court Jesters")
        expect(results.result).to eq "W"
      end
    end
    context "if the opponent beats the team in sets won" do
      it "returns L" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        match.add_set_result(Pva::SetResult.new(set: 1, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 2, home: 25, visitor: 22))
        match.add_set_result(Pva::SetResult.new(set: 3, home: 15, visitor: 8))
        results = match.results_for("Court Jesters")
        expect(results.result).to eq "L"
      end
    end
    context "if the team and the opponent tie in sets won" do
      context "but the team scored more total points than the opponent" do
        it "returns W" do
          match = Pva::Match.new(time: "1/1/2016 8:00pm",
                            home: "Mo Diggity",
                            visitor: "Court Jesters",
                            location: "PCC Sylvania",
                            division: "Coed A Thursday Doubleheaders")
          match.add_set_result(Pva::SetResult.new(set: 1, home: 21, visitor: 25))
          match.add_set_result(Pva::SetResult.new(set: 2, home: 25, visitor: 22))
          results = match.results_for("Court Jesters")
          expect(results.result).to eq "W"
        end
      end
      context "but the opponent scored more total points than the team" do
        it "returns L" do
          match = Pva::Match.new(time: "1/1/2016 8:00pm",
                            home: "Mo Diggity",
                            visitor: "Court Jesters",
                            location: "PCC Sylvania",
                            division: "Coed A Thursday Doubleheaders")
          match.add_set_result(Pva::SetResult.new(set: 1, home: 22, visitor: 25))
          match.add_set_result(Pva::SetResult.new(set: 2, home: 25, visitor: 21))
          results = match.results_for("Court Jesters")
          expect(results.result).to eq "L"
        end
      end
      context "and both teams scored the same number of total points" do
        it "returns T for tie" do
          match = Pva::Match.new(time: "1/1/2016 8:00pm",
                            home: "Mo Diggity",
                            visitor: "Court Jesters",
                            location: "PCC Sylvania",
                            division: "Coed A Thursday Doubleheaders")
          match.add_set_result(Pva::SetResult.new(set: 1, home: 22, visitor: 25))
          match.add_set_result(Pva::SetResult.new(set: 2, home: 25, visitor: 22))
          results = match.results_for("Court Jesters")
          expect(results.result).to eq "T"
        end
      end
    end
  end

  describe "#sets_won" do
    context "when the team wins 1 and the opponent wins 2" do
      it "returns 1" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        match.add_set_result(Pva::SetResult.new(set: 1, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 2, home: 25, visitor: 22))
        match.add_set_result(Pva::SetResult.new(set: 3, home: 15, visitor: 8))
        results = match.results_for("Court Jesters")
        expect(results.sets_won).to eq 1
      end
    end
    context "when the team wins 2 and the opponent wins 1" do
      it "returns 2" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        match.add_set_result(Pva::SetResult.new(set: 1, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 2, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 3, home: 15, visitor: 8))
        results = match.results_for("Court Jesters")
        expect(results.sets_won).to eq 2
      end
    end
    context "when the team wins 3 and the opponent wins 0" do
      it "returns 3" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        match.add_set_result(Pva::SetResult.new(set: 1, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 2, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 3, home: 8, visitor: 15))
        results = match.results_for("Court Jesters")
        expect(results.sets_won).to eq 3
      end
    end
  end

  describe "#sets_lost" do
    context "when the opponent wins 0 sets" do
      it "returns 0" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        match.add_set_result(Pva::SetResult.new(set: 1, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 2, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 3, home: 8, visitor: 15))
        results = match.results_for("Court Jesters")
        expect(results.sets_lost).to eq 0
      end
    end
    context "when the opponent wins 2 sets" do
      it "returns 2" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        match.add_set_result(Pva::SetResult.new(set: 1, home: 25, visitor: 22))
        match.add_set_result(Pva::SetResult.new(set: 2, home: 25, visitor: 22))
        match.add_set_result(Pva::SetResult.new(set: 3, home: 8, visitor: 15))
        results = match.results_for("Court Jesters")
        expect(results.sets_lost).to eq 2
      end
    end
  end

  describe "#point_differential" do
    it "returns the team's total points - the opponent's total points" do
      match1 = Pva::Match.new(time: "1/1/2016 8:00pm",
                         home: "Mo Diggity",
                         visitor: "Court Jesters",
                         location: "PCC Sylvania",
                         division: "Coed A Thursday Doubleheaders")
      match1.add_set_result(Pva::SetResult.new(set: 1, home: 25, visitor: 22))
      match1.add_set_result(Pva::SetResult.new(set: 2, home: 25, visitor: 22))
      match1.add_set_result(Pva::SetResult.new(set: 3, home: 15, visitor: 14))
      results = match1.results_for("Court Jesters")
      expect(results.point_differential).to eq -7

      match2 = Pva::Match.new(time: "1/1/2016 8:00pm",
                         home: "Mo Diggity",
                         visitor: "Court Jesters",
                         location: "PCC Sylvania",
                         division: "Coed A Thursday Doubleheaders")
      match2.add_set_result(Pva::SetResult.new(set: 1, home: 25, visitor: 22))
      match2.add_set_result(Pva::SetResult.new(set: 2, home: 22, visitor: 25))
      results = match2.results_for("Court Jesters")
      expect(results.point_differential).to eq 0
    end
  end

  describe "#match_points_earned" do
    context "if the team won all three matches" do
      it "returns 4.5" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        match.add_set_result(Pva::SetResult.new(set: 1, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 2, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 3, home: 8, visitor: 15))
        results = match.results_for("Court Jesters")
        expect(results.match_points_earned).to eq 4.5
      end
    end
    context "if the team won 2, lost 1, and had a positive point differential" do
      it "returns 4" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        match.add_set_result(Pva::SetResult.new(set: 1, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 2, home: 22, visitor: 25))
        match.add_set_result(Pva::SetResult.new(set: 3, home: 15, visitor: 12))
        results = match.results_for("Court Jesters")
        expect(results.match_points_earned).to eq 4
      end
    end
    context "if the team won 1, lost 2, and had a negative point differential" do
      it "returns 0.5" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        match.add_set_result(Pva::SetResult.new(set: 1, home: 25, visitor: 22))
        match.add_set_result(Pva::SetResult.new(set: 2, home: 25, visitor: 22))
        match.add_set_result(Pva::SetResult.new(set: 3, home: 14, visitor: 15))
        results = match.results_for("Court Jesters")
        expect(results.match_points_earned).to eq 0.5
      end
    end
    context "if the team lost all the sets" do
      it "returns 0" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        match.add_set_result(Pva::SetResult.new(set: 1, home: 25, visitor: 22))
        match.add_set_result(Pva::SetResult.new(set: 2, home: 25, visitor: 22))
        match.add_set_result(Pva::SetResult.new(set: 3, home: 15, visitor: 10))
        results = match.results_for("Court Jesters")
        expect(results.match_points_earned).to eq 0
      end
    end
  end

  describe "#to_s(opponent_name_column_width: :calculate)" do
    it "01/01/2016   8:00pm  Opponent Team Name  25-22  25-20  15-8   W       4.5" do
      match = Pva::Match.new(time: "1/1/2016 8:00pm",
                        home: "Mo Diggity",
                        visitor: "Court Jesters",
                        location: "PCC Sylvania",
                        division: "Coed A Thursday Doubleheaders")
      match.add_set_result(Pva::SetResult.new(set: 1, home: 25, visitor: 22))
      match.add_set_result(Pva::SetResult.new(set: 2, home: 25, visitor: 22))
      match.add_set_result(Pva::SetResult.new(set: 3, home: 15, visitor: 10))
      results = match.results_for("Court Jesters")
      expected = "01/01/2016   8:00pm  Mo Diggity  22-25  22-25  10-15  L       0.0"
      expect(results.to_s).to eq expected
    end

    context "when given an opponent name column width" do
      it "left justifies the opponent name within the given column width, pushes rest right" do
        match = Pva::Match.new(time: "1/1/2016 8:00pm",
                          home: "Mo Diggity",
                          visitor: "Court Jesters",
                          location: "PCC Sylvania",
                          division: "Coed A Thursday Doubleheaders")
        match.add_set_result(Pva::SetResult.new(set: 1, home: 25, visitor: 22))
        match.add_set_result(Pva::SetResult.new(set: 2, home: 25, visitor: 22))
        match.add_set_result(Pva::SetResult.new(set: 3, home: 15, visitor: 10))
        results = match.results_for("Mo Diggity")
        expected = "01/01/2016   8:00pm  Court Jesters         25-22  25-22  15-10  W       4.5"
        expect(results.to_s(opponent_name_column_width: 20)).to eq expected
      end
    end
  end
end
