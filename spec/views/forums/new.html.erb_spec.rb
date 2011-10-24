require 'spec_helper'

describe "forums/new.html.erb" do
  before(:each) do
    assign(:forum, stub_model(Forum).as_new_record)
  end

  it "renders new forum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forums_path, :method => "post" do
    end
  end
end
