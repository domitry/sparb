require "sparb/version"
require "sparb/variable"
require "sparb/prefix"
require "sparb/prefixes"
require "sparb/query"
require "sparb/monkey"

begin
  require "mikon"
rescue => e
  print "I strongly recommend you to install Mikon, an DataFrame gem."
  require "sparb/dataframe"
end

include Sparb
