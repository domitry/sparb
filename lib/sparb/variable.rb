module Sparb
  class Variable
    attr_reader :name
    
    def initialize(name, **options)
      @name = name
    end

    def to_s
      "?" + @name.to_s
    end

    def to_sparql; to_s; end
  end
end
