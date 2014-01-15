require 'spec_helper'

module Setty
  describe Options do
    it "has attribute getter" do
      options = Setty::Options[attribute: 'value']

      expect(options.attribute).to eq 'value'
      expect(options.missing).to be_nil
    end

    it "has attribute setter (should not be used)" do
      options = Setty::Options.new
      options.attribute = 'value'

      expect(options.attribute).to eq 'value'
    end

    it "has attribute checker" do
      options = Setty::Options[active: true, disabled: false]

      expect(options.active?).to be_true
      expect(options.disabled?).to be_false
      expect(options.missing?).to be_false
    end
  end
end
