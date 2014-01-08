require 'spec_helper'
require 'tempfile'
require 'active_support/ordered_options'
require 'active_support/core_ext/hash/keys.rb'

describe Setty do
  describe "#load" do
    it "loads yaml depending on environment variable" do
      path = generate_yaml <<-YAML
      production:
        enviroment: 'production'
      test:
        enviroment: 'test'
      YAML
      options = Setty.load(path, 'test')
      expect(options.enviroment).to eq 'test'
    end

    it "interpolates the yaml content" do
      path = generate_yaml <<-YAML
      test:
        enviroment: <%= 1 + 1 %>
      YAML
      options = Setty.load(path, 'test')
      expect(options.enviroment).to eq 2
    end

    it "returns an empty options for non existing yaml file" do
      options = Setty.load('non-existing', 'test')
      expect(options).to be_empty
    end
  end

  def generate_yaml(content)
    file = Tempfile.new('test.yml')
    file.write content
    file.close
    file
  end
end
