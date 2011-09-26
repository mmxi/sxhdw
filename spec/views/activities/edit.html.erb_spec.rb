require 'spec_helper'

describe "activities/edit.html.erb" do
  before(:each) do
    @activity = assign(:activity, stub_model(Activity))
  end

  it "renders the edit activity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => activities_path(@activity), :method => "post" do
    end
  end
end
