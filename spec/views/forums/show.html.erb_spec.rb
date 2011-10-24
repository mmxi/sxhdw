require 'spec_helper'

describe "forums/show.html.erb" do
  before(:each) do
    @forum = assign(:forum, stub_model(Forum))
  end

  it "renders attributes in <p>" do
    render
  end
end
