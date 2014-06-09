module Setty
  class Settings < Delegator
    def initialize(loader)
      @loader  = loader
      @options = loader.load_options
    end

    def __getobj__
      @options
    end

    def reload
      @options = @loader.load_options
    end
  end
end
