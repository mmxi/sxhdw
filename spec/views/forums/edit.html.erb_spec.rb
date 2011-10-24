require 'spec_helper'

describe "forums/edit.html.erb" do
  before(:each) do
    @forum = assign(:forum, stub_model(Forum))
  end

  it "renders the edit forum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forums_path(@forum), :method => "post" do
    end
  end
end
