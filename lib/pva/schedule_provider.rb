module Pva
  class ScheduleProvider

    SCHEDULES_URL = 'http://portlandvolleyball.org/schedules.php'

    def get_schedule(team_id)
      matches_data(team_id).map { |m| match_from_array(m) }
    end

    private

    def matches_data(team_id)
      response = HTTParty.post(SCHEDULES_URL, body: { teams: team_id })
      doc = Nokogiri::HTML(response)

      doc.css('tr')[1..-1]
        .map { |tr| tr.element_children.map(&:content) }
    end

    def match_from_array(m)
      Match.new({
        time: "#{m[0]} #{m[1]} pm",
        home: m[2],
        visitor: m[3],
        location: m[4],
        division: m[5]
      })
    end

  end
end
