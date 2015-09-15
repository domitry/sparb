require 'net/http'
require 'uri'

module Sparb
  class Where
    attr_reader :dependencies

    def initialize(sub, pre, obj)
      @triples = [sub, pre, obj]
      @dependencies = @triples
        .select{|o| o.is_a? PREFIX_CHILD}
        .map{|o| o.parent}
    end
    
    def to_s
        @triples.map{|o| o.to_sparql}.join(" ")
    end

    def to_sparql
      self.to_s + " ."
    end
  end

  class Query
    def initialize(endpoint)
      @endpoint = endpoint
      @wheres = []
      @select = []
      @limit = -1
    end

    # subject, predicate and object
    def where(sub, pre, obj)
      @wheres.push(Where.new(sub, pre, obj))
      self
    end

    def filter(block)
      raise NotImplementedError
    end

    def select(*args)
      @select = args.map{|v| v.to_s}
      self
    end

    def limit(num)
      @limit = num
      self
    end

    def optional(sub, pre, obj)
      raise NotImplementedError
    end

    def send(**options)
      options = {
       # "default-graph-uri"=> uri,
        query: self.to_sparql,
        timeout: 30000,
        format: "csv"
      }.merge(options)

      # e.g. "http://dbpedia.org/sparql"
      uri = [@endpoint, URI.encode_www_form(options)].join("?")

      res = Net::HTTP.get(URI.parse(uri))

      file = Tempfile.new("dataframe")
      file.write(res)
      file.close

      Mikon::DataFrame.from_csv(file.path)
    end

    def to_sparql
      [
       @wheres.map{|w| w.dependencies.map{|d| d.to_sparql}}.uniq,
       "SELECT " + (@select.length == 0 ? "*" : @select.join(" ")),
       "WHERE {",
       @wheres.map{|w| w.to_sparql},
       "}",
       (@limit < 0 ? "" : "LIMIT " + @limit.to_s)
      ].flatten.join("\n")
    end
  end
end
