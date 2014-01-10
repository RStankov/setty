require 'setty/version'
require 'erb'
require 'yaml'

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
      load_options @base_path
    end

    private

    def load_options(path)
      options = load_options_from_file "#{path}.yml"
      find_nested_options(path).each do |sub_path|
        options[:"#{File.basename(sub_path)}"] = load_options(sub_path)
      end
      options
    end

    def find_nested_options(path)
      Dir.glob(File.join(path, '/*')).map { |file_path| "#{path}/#{File.basename(file_path, '.yml')}" }.uniq
    end

    def load_options_from_file(path)
      return ActiveSupport::OrderedOptions.new unless File.readable? path

      yaml_content       = ERB.new(File.read(path)).result
      options            = YAML.load yaml_content
      enviroment_options = options[@enviroment.to_s]

      ActiveSupport::OrderedOptions[enviroment_options.symbolize_keys]
    end
  end
end
