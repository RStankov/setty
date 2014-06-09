require 'setty/version'
require 'setty/options'
require 'setty/loader'
require 'setty/settings'
require 'setty/railtie' if defined? Rails

module Setty
  def self.load(path, enviroment)
    Settings.new Loader.new(path, enviroment)
  end
end
