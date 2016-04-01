module Pva
  class Standing

    attr_reader :team_name, :wins, :losses, :winning_percentage,
      :match_points, :match_points_possible, :match_point_percentage

    def initialize(params={})
      @team_name = params[:team_name]
      @wins = Integer(params[:wins])
      @losses = Integer(params[:losses])
      @winning_percentage = Float(params[:winning_percentage])
      @match_points = Float(params[:match_points])
      @match_points_possible = Float(params[:match_points_possible])
      @match_point_percentage = Float(params[:match_point_percentage])
    end

  end
end
