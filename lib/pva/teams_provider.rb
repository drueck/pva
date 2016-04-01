module Pva
  class TeamsProvider

    attr_reader :cache

    def initialize
      @cache = TeamsCache.new
    end

    def lookup(team_name)
      team = cache.lookup(team_name)
      if team.nil?
        team = all.find { |t| t.name.casecmp(team_name) == 0 }
        cache.store(team) unless team.nil?
      end
      team
    end

    def all
      response = HTTParty.get('http://portlandvolleyball.org/schedules.php')
      doc = Nokogiri::HTML(response)
      teams_select = doc.css('select[name=teams]')
      team_options = teams_select.children
      team_options.map { |option| team_from_option(option) }
        .reject { |t| t == :not_a_team }
    end

    private

    def team_from_option(option)
      id = option['value']
      return :not_a_team if id.nil? || id == ""

      name, division = name_and_division(option.content)
      Team.new(id: id, name: name, division: division)
    end

    def name_and_division(team_string)
      expected_format = /(?<name>.+) \((?<division>.+?)\)/
      if (match_data = expected_format.match(team_string))
        return [match_data[:name], match_data[:division]]
      end
      [team_string, "Unknown"]
    end

  end
end
