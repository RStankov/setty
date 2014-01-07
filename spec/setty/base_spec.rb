require 'spec_helper'
require 'tempfile'
require 'active_support/ordered_options'
require 'active_support/core_ext/hash/keys.rb'

describe Setty do
  describe "#options_from_file" do
    it "loads yaml depending on environment variable" do
      path = generate_yaml <<-YAML
      production:
        enviroment: 'production'
      test:
        enviroment: 'test'
      YAML
      options = Setty.options_from_file(path, 'test')
      expect(options.enviroment).to eq 'test'
    end

    it "interpolates the yaml content" do
      path = generate_yaml <<-YAML
      test:
        enviroment: <%= 1 + 1 %>
      YAML
      options = Setty.options_from_file(path, 'test')
      expect(options.enviroment).to eq 2
    end
  end

  def generate_yaml(content)
    file = Tempfile.new('test.yml')
    file.write content
    file.close
    file
  end
end
