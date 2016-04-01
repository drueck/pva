module Pva
  class TeamsCache

    attr_reader :teams_file

    def initialize(teams_file=nil)
      @teams_file = teams_file || ENV['HOME'] + '/.pva'
    end

    def lookup(team_name)
      return nil unless File.exist?(teams_file)
      CSV.foreach(teams_file) do |row|
        if row[1].casecmp(team_name) == 0
          return Team.new(id: row[0].to_i, name: row[1], division: row[2])
        end
      end
      return nil
    end

    def store(team)
      if lookup(team.name).nil?
        CSV.open(teams_file, 'ab') do |csv|
          csv << [ "#{team.id}", "#{team.name}", "#{team.division}" ]
        end
      end
    end

    def all
      return [] unless File.exist?(teams_file)
      teams = []
      CSV.foreach(teams_file) do |row|
        teams << Team.new(id: row[0].to_i, name: row[1], division: row[2])
      end
      teams
    end

  end
end
