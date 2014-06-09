require 'erb'
require 'yaml'
require 'pathname'
require 'active_support/core_ext/hash/keys.rb'
require 'active_support/core_ext/string/inflections.rb'

module Setty
  MissingEnviromentError = Class.new(RuntimeError)
  NotReadableFileError = Class.new(RuntimeError)

  class Loader
    def initialize(path, enviroment)
      @base_path  = Pathname(path)
      @enviroment = enviroment.to_s
    end

    def load_options
      load_option_and_sub_options @base_path
    end

    private

    def load_option_and_sub_options(path)
      options = load_options_from_file path.sub_ext('.yml')
      find_nested_options(path).each do |sub_path|
        options[sub_path.basename.to_s.to_sym] = load_option_and_sub_options sub_path
      end
      options
    end

    def find_nested_options(path)
      Pathname.glob(path.join('*')).map { |file_path| path.join file_path.basename('.yml') }.uniq
    end

    def load_options_from_file(path)
      enviroment_options = load_enviroment_options_from_file path

      raise MissingEnviromentError, %Q(Missing "#{@enviroment}" key in #{path}) if enviroment_options.nil?

      Options[enviroment_options.symbolize_keys]
    end

    def load_enviroment_options_from_file(file)
      return {} unless file.exist?

      raise NotReadableFileError, %Q(Settings file "#{file}" is not readable) unless file.readable?

      yaml_content = ERB.new(file.read).result
      options      = YAML.load yaml_content

      options[@enviroment]
    end
  end
end
