module Pva
  class ScheduleProvider

    SCHEDULES_URL = 'https://portlandvolleyball.org/schedules.php'

    def get_schedule(team_id)
      matches_data(team_id).map { |m| match_from_array(m) }
    end

    private

    def matches_data(team_id)
      response = HTTParty.post(SCHEDULES_URL, body: { teams: team_id })
      doc = Nokogiri::HTML(response.body)

      doc.css('tr')[1..-1]
        .map { |tr| tr.element_children.map(&:content).map(&:strip) }
    end

    def match_from_array(m)
      Match.new({
        time: "#{m[0]} #{m[1]} pm",
        court: m[2],
        home: m[3],
        visitor: m[4],
        location: m[5],
        division: m[6]
      })
    end

  end
end
