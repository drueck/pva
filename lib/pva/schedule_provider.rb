module Pva
  class ScheduleProvider

    SCHEDULES_URL = 'http://portlandvolleyball.org/schedules.php'

    def get_schedule(team)
      matches_data(team).map { |m| match_from_array(m) }
    end

    private

    def matches_data(team)
      response = HTTParty.get(SCHEDULES_URL)
      doc = Nokogiri::HTML(response)

      doc.css("table.schedule-table")
        .xpath("//tr[(td//text()[contains(., '#{team.name}')]) and (td[6]//text()[contains(., '#{team.division}')])]")
        .map { |tr| tr.element_children.map(&:content).map(&:strip) }
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
