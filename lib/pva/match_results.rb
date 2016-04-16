module Pva
  class MatchResults

    def self.header_row(opponent_name_column_width:)
      format = "%-10s  %7s  %-#{opponent_name_column_width}s  " +
               "%-5s  %-5s  %-5s  %-6s  %-4s"
      data = ["Date", "Time", "Opponent", "Set 1", "Set 2",
              "Set 3", "Result", "MPs"]
      format % data
    end

    def initialize(match, perspective:)
      @match = match
      @team_side = perspective
      @opponent_side = (perspective == :home ? :visitor : :home)
    end

    def team
      @team ||= match.public_send(team_side)
    end

    def opponent
      @opponent ||= match.public_send(opponent_side)
    end

    def result
      return result_by_point_differential if sets_won == sets_lost
      sets_won > sets_lost ? "W" : "L"
    end

    def sets_won
      @sets_won ||= set_results.map(&:winner).count(team_side)
    end

    def sets_lost
      @sets_lost ||= set_results.map(&:winner).count(opponent_side)
    end

    def point_differential
      @point_differential ||= set_results
        .map { |r| r.public_send(team_side) - r.public_send(opponent_side) }
        .reduce(:+)
    end

    def match_points_earned
      points = sets_won * 0.5
      points += 1 if point_differential > 0
      points += 2 if result == "W"
      points
    end

    def to_s(opponent_name_column_width: self.opponent.length)
      format = "%-10s  %7s  %-#{opponent_name_column_width}s  " +
               "%-5s  %-5s  %-5s  %-6s  %3.1f"
      data = [match_date_string, match_time_string, opponent,
              set_scores_string(1),
              set_scores_string(2),
              set_scores_string(3),
              result, match_points_earned]
      format % data
    end

    private

    attr_reader :match, :team_side, :opponent_side

    def match_date_string
      match.time.strftime('%m/%d/%Y')
    end

    def match_time_string
      match.time.strftime('%l:%M%P')
    end

    def set_scores_string(set_number)
      set_result = set_results.find { |sr| sr.set == set_number }
      return "" if set_result.nil?

      team_score = set_result.public_send(team_side)
      opponent_score = set_result.public_send(opponent_side)
      "#{team_score}-#{opponent_score}"
    end

    def set_results
      match.set_results
    end

    def result_by_point_differential
      return "T" if point_differential == 0
      point_differential > 0 ? "W" : "L"
    end

  end
end
