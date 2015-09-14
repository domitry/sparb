# SPARB
SPARQL + Ruby = SPARB

## Demos
[TODO: some notebooks here]()

## Usage

```ruby
require 'sparb'

dbp = PREFIXES.dbp
rdf = PREFIXES.rdf
geo = PREFIXES.geo
dbo = PREFIXES.dbo

q = Query.new(dbp)
   .where(country, rdf.type, dbo.Country)
   .where(country, dbo.capital, capital)

df = q.send
```

This Ruby code will generate SPARQL equal to the following one:

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX geo: <http://www.w3.org/2003/01/geo/wgs84_pos#>
PREFIX dbo: <http://dbpedia.org/ontology/>

SELECT *
WHERE {
  ?country rdf:type dbo:Country .
  ?country  dbo:capital ?capital .
}
```

You can add new conditions to the exsisting `Query` object:

```ruby
q.where(continent, dbp.continent, country)
 .filter{ continent == "Asia" }

df = q.send
```

## Acknowledgement

This software will be developed as a product in [BioHackathon 2015](), held in Nagasaki University.  
(But not yet :)

## LICENSE
MIT License
