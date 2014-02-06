require 'spec_helper'

describe AppSettings do
  it "has product minimum photos set to 0" do
    expect(AppSettings.products.minumum_photos_count).to eq 0
  end
end
