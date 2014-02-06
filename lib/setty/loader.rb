require 'erb'
require 'yaml'
require 'active_support/core_ext/hash/keys.rb'
require 'active_support/core_ext/string/inflections.rb'

module Setty
  MissingEnviromentError = Class.new(RuntimeError)

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
      enviroment_options = load_enviroment_options_from_file path

      raise MissingEnviromentError, %Q(Missing "#{@enviroment}" key in #{path}) if enviroment_options.nil?

      Options[enviroment_options.symbolize_keys]
    end

    def load_enviroment_options_from_file(path)
      return {} unless File.readable? path

      yaml_content = ERB.new(File.read(path)).result
      options      = YAML.load yaml_content

      options[@enviroment.to_s]
    end
  end
end
