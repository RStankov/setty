require 'spec_helper'
require 'tempfile'
require 'active_support/ordered_options'
require 'active_support/core_ext/hash/keys.rb'

describe Setty do
  def fixture(file_name)
    File.expand_path File.join(File.dirname(__FILE__), '..', 'fixtures', file_name)
  end

  describe "#load" do
    it "loads yaml depending on environment variable" do
      path = fixture 'settings'
      options = Setty.load(path, 'test')
      expect(options.enviroment).to eq 'test'
    end

    it "interpolates the yaml content" do
      path = fixture 'settings'
      options = Setty.load(path, 'test')
      expect(options.interpolation).to eq 2
    end

    it "returns an empty options for non existing yaml file" do
      options = Setty.load('non-existing', 'test')
      expect(options).to be_empty
    end
  end
end
