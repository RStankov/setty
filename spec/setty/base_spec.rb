require 'spec_helper'

describe Setty do
  def fixture(file_name)
    File.expand_path File.join(File.dirname(__FILE__), '..', 'fixtures', file_name)
  end

  describe "#load" do
    it "returns settings" do
      allow(Setty::Loader).to receive(:new).with('path', 'enviroment').and_return 'loader'
      allow(Setty::Settings).to receive(:new).with('loader').and_return 'settings'

      expect(Setty.load('path', 'enviroment')).to eq 'settings'
    end
  end
end
