module Pva
  class DivisionStandings

    attr_reader :division_name, :standings

    def initialize(params={})
      @division_name = params[:division_name]
      @standings = params[:standings]
    end

    def to_s
      division_name + "\n\n" +
        formatted_headings + "\n" +
        formatted_standings
    end

    private

    def formatted_headings
      sprintf(format, *headings)
    end

    def formatted_standings
      standings.map { |s| sprintf(format, *column_values(s)) }.join("\n")
    end

    def format
      @format ||= "%-#{name_column_width}s" +
        numeric_column_widths.map { |w| "%#{w}s" }.join
    end

    def column_values(stats)
      [stats.team_name,
       stats.wins,
       stats.losses,
       sprintf("%.02f", stats.winning_percentage),
       sprintf("%4.1f / %4.1f", stats.match_points, stats.match_points_possible),
       sprintf("%.2f", stats.match_point_percentage)]
    end

    def headings
      ["Team", "Wins", "Losses", "Winning %", "Match Points", "Match Point %"]
    end

    def name_column_width
      ["Team".length, max_team_name_length].max + gutter_width
    end

    def max_team_name_length
      return 0 if standings.empty?
      standings.map(&:team_name).map(&:length).max
    end

    def numeric_column_widths
      headings[1..-1].map { |heading| heading.length + gutter_width }
    end

    def gutter_width
      2
    end

  end
end
