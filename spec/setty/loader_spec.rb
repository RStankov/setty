require 'spec_helper'

module Setty
  describe Loader do
    def fixture(file_name)
      File.expand_path File.join(File.dirname(__FILE__), '..', 'fixtures', file_name)
    end

    it "loads yaml depending on environment variable" do
      options = load 'settings'
      expect(options.enviroment).to eq 'test'
      expect(options.active?).to be_truthy
    end

    it "does not complain about missing yaml file" do
      options = load 'non-existing'
      expect(options).to be_empty
    end

    it "interpolates the yaml content" do
      options = load 'settings'
      expect(options.interpolation).to eq 2
    end

    it "supports nested settings" do
      options = load 'settings'
      expect(options.inner_0.inner).to eq 0
      expect(options.inner_1.inner).to eq 1
      expect(options.inner_1.inner_2.inner_3.inner).to eq 123
    end

    it "supports empty nested settings" do
      options = load 'settings'
      expect(options.inner_empty).to eq({})
    end

    it "raises error on missing environment is settings" do
      expect { load 'settings', 'bongus enviroment' }.to raise_error MissingEnviromentError
    end

    it "raises error on not readable settings file" do
      begin
        File.chmod(0200, fixture('forbidden.yml'))

        expect { load 'forbidden' }.to raise_error NotReadableFileError
      ensure
        File.chmod(0777, fixture('forbidden.yml'))
      end
    end

    def load(name, env = 'test')
      Loader.new(fixture(name), env).load_options
    end
  end
end
