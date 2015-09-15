module Sparb
  path = File.join(ENV["HOME"], "/.sparb/setting.json")
  
  def method_missing(name, *args)
    if name[-1] == "_"
      return Variable.new(name)
    end
    super
  end

  def is_a
    raise NotImplementedError
  end
end
