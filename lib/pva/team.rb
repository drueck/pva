module Pva
  class Team

    attr_reader :id, :name, :division

    def initialize(params={})
      @id = params[:id]
      @name = params[:name]
      @division = params[:division]
    end

    def to_s
      "#{name} (#{division})"
    end

  end
end
