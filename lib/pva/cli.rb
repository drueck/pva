module Pva
  class Cli

    class << self

      def run(*args)
        if args.nil? || args.empty?
          self.usage
        else
          self.public_send(args.shift, *args)
        end
      end

      def usage
        puts %{usage: pva command [options]

commands:
teams                   : list all current teams
schedules 'team name'   : show the schedule for the given team
schedules               : show schedules for all of your teams
standings 'team name'   : show standings for the given team's division
standings               : show standings for all of your teams' divisions
scores 'team name'      : show match results for the given team
scores                  : show match results for all of your teams
help                    : display this message

Each time you look up something for a team that team is stored
in your teams cache at ~/.pva. This list is used to determine which
teams you are interested in if you don't specify one. If you
want to delete a team, simply delete its line from ~/.pva. To add
a team, look up its schedule or standings and it will be added to
the list.

}
      end
      alias :help :usage
      alias :h :usage

      def schedules(*args)
        if args.empty?
          teams_cache = TeamsCache.new
          teams = teams_cache.all
          if teams.empty?
            puts "No teams were found in your teams cache. "\
              "Look up a team's schedule to add that team."
          else
            puts "Schedules for Your Teams:\n\n"
            teams.each do |team|
              schedules(team.name)
              puts ""
            end
          end
        else
          team_name = args.shift
          teams_provider = TeamsProvider.new
          team = teams_provider.lookup(team_name)
          if team.nil?
            puts "Couldn't find the team you specified. Here is the current list of teams..."
            self.teams
          else
            puts "Schedule for #{team.name}"
            schedule_provider = ScheduleProvider.new
            matches = schedule_provider.get_schedule(team.id)
            matches.each { |m| puts m }
          end
        end
      end
      alias :schedule :schedules

      def standings(*args)
        if args.empty?
          teams = TeamsCache.new.all
          if teams.empty?
            puts "No teams were found in your teams cache. "\
              "Look up a team's standings to add that team."
          else
            puts "Standings for Your Teams' Divisions:\n\n"
            teams.map(&:division).uniq.each do |division|
              puts DivisionStandingsProvider.new.get_standings(division)
              puts ""
            end
          end
        else
          team_name = args.shift
          teams_provider = TeamsProvider.new
          team = teams_provider.lookup(team_name)
          if team.nil?
            puts "Couldn't find the team you specified. Here is the current list of teams..."
            self.teams
          else
            puts DivisionStandingsProvider.new.get_standings(team.division)
            puts ""
          end
        end
      end

      def scores(*args)
        if args.empty?
          teams = TeamsCache.new.all
          if teams.empty?
            puts "No teams were found in your teams cache. "\
              "Look up a team's scores to add that team."
          else
            puts "Scores for your teams:\n\n"
            teams.each do |team|
              scores(team.name)
              puts ""
            end
          end
        else
          team_name = args.shift
          teams_provider = TeamsProvider.new
          team = teams_provider.lookup(team_name)
          if team.nil?
            puts "Couldn't find the team you specified. Here is the current list of teams..."
            self.teams
          else
            puts "Scores for #{team.name}"
            puts ""
            match_results_provider = MatchResultsProvider.new
            match_results = match_results_provider.get_match_results(team)
            width = match_results.map(&:opponent).map(&:length).max
            puts MatchResults.header_row(opponent_name_column_width: width)
            match_results.each do |mr|
              puts mr.to_s(opponent_name_column_width: width)
            end
          end
        end

      end

      def teams(*args)
        teams = TeamsProvider.new.all
        teams.each { |t| puts t }
      end

      def method_missing(method, *args, &blk)
        puts "There is no #{method} command in pva"
        self.usage
      end

    end

  end
end
