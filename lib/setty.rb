require 'setty/version'
require 'erb'

module Setty
  def self.load(path, enviroment)
    Loader.new(path, enviroment).options
  end

  class Loader
    def initialize(path, enviroment)
      @base_path  = path
      @enviroment = enviroment
    end

    def options
      load "#{@base_path}.yml"
    end

    private

    def load(path)
      return ActiveSupport::OrderedOptions.new unless File.readable? path

      yaml_content       = ERB.new(File.read(path)).result
      options            = YAML.load yaml_content
      enviroment_options = options[@enviroment.to_s]

      ActiveSupport::OrderedOptions[enviroment_options.symbolize_keys]
    end
  end
end
