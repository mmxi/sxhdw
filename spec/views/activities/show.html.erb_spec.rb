require 'spec_helper'

describe "activities/show.html.erb" do
  before(:each) do
    @activity = assign(:activity, stub_model(Activity))
  end

  it "renders attributes in <p>" do
    render
  end
end
