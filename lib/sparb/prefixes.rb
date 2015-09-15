module Sparb
  class PREFIXES
    [
     ["dbp", "http://dbpedia.org/sparql"],
     ["rdf", "http://www.w3.org/1999/02/22-rdf-syntax-ns#"],
     ["geo", "http://www.w3.org/2003/01/geo/wgs84_pos#"],
     ["dbo", "http://dbpedia.org/ontology/"],
     ["rdfs", "http://www.w3.org/2000/01/rdf-schema#"]
    ].each{ |pair|
      pre = PREFIX.new(*pair)
      define_singleton_method(pair[0]){
        pre
      }
    }
  end
end
