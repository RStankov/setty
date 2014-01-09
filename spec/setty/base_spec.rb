require 'spec_helper'
require 'tempfile'
require 'active_support/ordered_options'
require 'active_support/core_ext/hash/keys.rb'
require 'active_support/core_ext/string/inflections.rb'

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

    it "supports nested settings" do
      path = fixture 'settings'
      options = Setty.load(path, 'test')
      expect(options.inner_0.inner).to eq 0
      expect(options.inner_1.inner).to eq 1
      expect(options.inner_1.inner_2.inner_3.inner).to eq 123
    end

    it "supports empty nested settings" do
      path = fixture 'settings'
      options = Setty.load(path, 'test')
      expect(options.inner_empty).to eq({})
    end
  end
end
