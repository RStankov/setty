require 'setty/version'
require 'setty/options'
require 'setty/loader'

module Setty
  def self.load(path, enviroment)
    Loader.new(path, enviroment).options
  end
end
