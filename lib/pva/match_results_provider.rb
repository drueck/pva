require "pp"
module Pva
  class MatchResultsProvider

    MATCH_RESULTS_URL = "http://portlandvolleyball.org/scores.php"
    MIN_COLUMN_COUNT = 5

    def get_match_results(team)
      match_results_data(team).map { |mr|
        match_results_from_array(mr, team_name: team.name) }
    end

    private

    def match_results_data(team)
      response = HTTParty.get(MATCH_RESULTS_URL)
      doc = Nokogiri::HTML(response)

      rows_for_team_xpath = "//tr[(td//text()[contains(., '#{team.name}')]) " +
        "and (td[3]//text()[contains(., '#{team.division}')])]"

      scores_rows = doc
        .xpath(rows_for_team_xpath)
        .map { |tr| tr.element_children.map(&:content).map(&:strip) }

      have_scores_data?(scores_rows) ? scores_rows : []
    end

    def have_scores_data?(scores_rows)
      return false if scores_rows.nil?
      return false if scores_rows.length < 1
      return false if scores_rows.first.nil?
      return false if scores_rows.first.length < MIN_COLUMN_COUNT
      true
    end

    def match_results_from_array(mr, team_name:)
      match = match_from_array(mr)
      set_results_from_array(mr).each do |set_result|
        match.add_set_result(set_result)
      end
      match.results_for(team_name)
    end

    def match_from_array(mr)
      Match.new({
        time: "#{mr[0]} #{mr[1]} pm",
        home: mr[3],
        visitor: mr[4],
        location: "Unknown",
        division: mr[2]
      })
    end

    def set_results_from_array(mr)
      mr[5..-1].each_with_index.map { |scores, set_index|
          set_result_from_string(scores, set: set_index + 1) }.compact
    end

    def set_result_from_string(scores_string, set:)
      return nil unless /(?<home>\d+)\s+-\s+(?<visitor>\d+)/ =~ scores_string
      SetResult.new(set: set, home: home.to_i, visitor: visitor.to_i)
    end

  end
end
