require 'spec_helper'

describe Setty do
  def fixture(file_name)
    File.expand_path File.join(File.dirname(__FILE__), '..', 'fixtures', file_name)
  end

  describe "#load" do
    it "returns loaded options" do
      loader = double options: 'options'
      allow(Setty::Loader).to receive(:new).with('path', 'enviroment').and_return loader

      expect(Setty.load('path', 'enviroment')).to eq 'options'
    end
  end
end
