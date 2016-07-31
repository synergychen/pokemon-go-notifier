module Exceptions
  class CrawlError < StandardError
    def initialize(msg = "Fail to parse data from PokeVision")
      super(msg)
    end
  end
end
