require 'setty/version'
require 'setty/options'
require 'setty/loader'
require 'setty/railtie' if defined? Rails

module Setty
  def self.load(path, enviroment)
    Loader.new(path, enviroment).load_options
  end
end
