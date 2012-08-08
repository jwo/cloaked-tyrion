# Extremely simple autoloading implementation
class Module
  def const_missing(const)
    puts "trying to find #{const}"
    path = "./#{name.gsub('::', '/')}/#{const}"
    path.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    require path.downcase
    const_defined?(const) ? const_get(const) : super
  rescue LoadError => error
    warn(error.message)
    super
  end
end

puts Cool::Yo.new.to_s
