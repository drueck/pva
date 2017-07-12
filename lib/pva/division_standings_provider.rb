module Pva
  class DivisionStandingsProvider

    STANDINGS_URL = 'https://portlandvolleyball.org/standings.php'

    def get_standings(division_name)
      DivisionStandings.new(division_name: division_name,
                            standings: standings(division_name))
    end

    private

    def standings(division_name)
      standings_data(division_name).map { |s| standing_from_array(s) }
    end

    def standings_data(division_name)
      standings_rows(division_name)
        .map { |tr| tr.element_children.map(&:content) }
    end

    def standings_rows(division_name)
      response = HTTParty.get(STANDINGS_URL)
      doc = Nokogiri::HTML(response)
      doc.xpath("//a[@name='#{division_name}']/following::table[1]/tr")[1..-1] || []
    end

    def standing_from_array(s)
      Standing.new(
        team_name: s[0],
        wins: s[1],
        losses: s[2],
        winning_percentage: s[3],
        match_points: s[4],
        match_points_possible: s[5],
        match_point_percentage: s[6]
      )
    end

  end
end
