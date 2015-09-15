module Sparb
  class PREFIX
    attr_reader :name, :url

    def initialize(name, url)
      @name = name
      @url = url
    end

    def to_s
      @url
    end

    def to_sparql
      "PREFIX #{@name}: <#{@url}>"
    end

    def method_missing(name, *args)
      PREFIX_CHILD.new(self, name)
    end

    def to_ary; end
    def to_str; to_s; end
  end

  class PREFIX_CHILD
    attr_reader :parent, :name

    def initialize(parent, name)
      @parent=parent; @name=name
    end

    def to_sparql
      [parent.name, self.name].join(":")
    end
  end
end
