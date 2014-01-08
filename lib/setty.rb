require 'setty/version'
require 'erb'

module Setty
  def self.load(path, enviroment)
    Loader.new(path, enviroment).options
  end

  module DelegateToOptions
    def method_missing(method, *args)
      @options.public_send method, *args
    end

    def respond_to_missing?(method)
      @options.respond_to? method
    end
  end

  class Loader
    def initialize(path, enviroment)
      @base_path  = path
      @enviroment = enviroment
    end

    def options
      build_module load("#{@base_path}.yml")
    end

    private

    def build_module(options)
      Module.new do
        extend DelegateToOptions

        @options = options
      end
    end

    def load(path)
      return ActiveSupport::OrderedOptions.new unless File.readable? path

      yaml_content       = ERB.new(File.read(path)).result
      options            = YAML.load yaml_content
      enviroment_options = options[@enviroment.to_s]

      ActiveSupport::OrderedOptions[enviroment_options.symbolize_keys]
    end
  end
end
