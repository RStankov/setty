require 'spec_helper'

module Setty
  describe Settings do
    let(:options) { 'options' }
    let(:loader) { double 'Loader', load_options: options }

    it "delegates to loader's loaded options" do
      config = Settings.new(loader)

      expect(config).to eq options
    end

    it "caches the loaded options" do
      loader.should_receive(:load_options).once

      config = Settings.new(loader)

      2.times { config.size }
    end

    describe "#reload" do
      it "loads options again from the loader" do
        config = Settings.new(loader)

        loader.stub load_options: 'new options'

        config.reload

        expect(config).to eq 'new options'
      end
    end
  end
end
