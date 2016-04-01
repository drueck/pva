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
scores 'team name'      : not yet implemented
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

  # Scores for Court Jesters
  #
  # Date        Time     Opponent          Set 1  Set 2  Set 3  Result  MPs
  # 01/01/2016   8:00pm  Two Dink Minimum  25-22  25-20  15-8   W       4.5
  # 01/01/2016   9:00pm  Two Dink Minimum  25-22  25-20  15-8   W       4.5
  # 01/01/2016  10:00pm  Two Dink Minimum  25-22  25-20  15-8   W       4.5
  #
  # %-10s  %7s  #-{opponent_name_column_width}s  %-5s  %-5s  %-5s  %-6s  %3.1f
  #
  # Record: 1-0, 4.5 Match Points of 4.5 Possible
  #
  # Match Point Calculation
  # .5 for each set won
  # 1 for most total points in the match
  # 2 for winning the match

      # def scores(*args)
      #   if args.empty?
      #     teams = TeamsCache.new.all
      #     if teams.empty?
      #       puts "No teams were found in your teams cache. "\
      #         "Look up a team's scores to add that team."
      #     else
      #       puts "Scores for your teams:\n\n"
      #       teams.each do |team|
      #         scores(team.name)
      #         puts ""
      #       end
      #     end
      #   else
      #     team_name = args.shift
      #     teams_provider = TeamsProvider.new
      #     team = teams_provider.lookup(team_name)
      #     if team.nil?
      #       puts "Couldn't find the team you specified. Here is the current list of teams..."
      #       self.teams
      #     else
      #       puts "Scores for #{team.name}"
      #       scores_provider = ScoresProvider.new
      #       match_scores =
      #       matches = schedule_provider.get_schedule(team.id)
      #       matches.each { |m| puts m }
      #     end
      #   end

      # end

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
