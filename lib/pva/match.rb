module Pva
  class Match

    attr_accessor :time, :home, :visitor, :location, :division, :set_results

    def initialize(params={})
      @time = Chronic.parse(params[:time])
      @home = params[:home]
      @visitor = params[:visitor]
      @location = params[:location]
      @division = params[:division]
      @set_results = []
    end

    def to_s
      formatted_time = time.strftime('%-m/%-e %l:%M%P')
      "#{formatted_time} #{home} vs. #{visitor} at #{location}"
    end

    def add_set_result(set_result)
      set_results << set_result
    end

    def results_for(team)
      return nil unless [home, visitor].include?(team)
      perspective = (team == home ? :home : :visitor)
      MatchResults.new(self, perspective: perspective)
    end

    def to_s
      return "#{formatted_date} BYE" if bye?
      "#{formatted_date_and_time} #{home} vs. #{visitor} at #{location}"
    end

    def bye?
      location == "BYE"
    end

    private

    def formatted_date_and_time
      time ? time.strftime('%-m/%e %l:%M%P') : unknown_time
    end

    def formatted_date
      time ? time.strftime('%-m/%e -------') : unknown_time
    end

    def unknown_time
      "??/?? ?:????"
    end

  end
end
