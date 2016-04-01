module Pva
  class SetResult

    def initialize(set:, home:, visitor:)
      @set = set
      @home = home
      @visitor = visitor
    end

    attr_accessor :set, :home, :visitor

    def winner
      return :tie if home == visitor
      home > visitor ? :home : :visitor
    end

    def loser
      return :tie if winner == :tie
      winner == :home ? :visitor : :home
    end

  end
end
