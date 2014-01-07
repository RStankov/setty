require "setty/version"

module Setty
  def self.options_from_file(path, enviroment)
    options = YAML.load_file path
    enviroment_options = options[enviroment.to_s]
    ActiveSupport::OrderedOptions[enviroment_options.symbolize_keys]
  end
end
