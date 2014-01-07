require 'spec_helper'
require 'tempfile'
require 'active_support/ordered_options'
require 'active_support/core_ext/hash/keys.rb'

describe Setty do
  it "can load yml file" do
    path = generate_yaml <<-YAML
      production:
        enviroment: 'production'
      test:
        enviroment: 'test'
    YAML
    options = Setty.options_from_file(path, 'test')
    expect(options.enviroment).to eq 'test'
  end

  def generate_yaml(content)
    file = Tempfile.new('test.yml')
    file.write content
    file.close
    file
  end
end
