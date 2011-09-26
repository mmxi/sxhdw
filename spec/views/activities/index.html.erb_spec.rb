require 'spec_helper'

describe "activities/index.html.erb" do
  before(:each) do
    assign(:activities, [
      stub_model(Activity),
      stub_model(Activity)
    ])
  end

  it "renders a list of activities" do
    render
  end
end
