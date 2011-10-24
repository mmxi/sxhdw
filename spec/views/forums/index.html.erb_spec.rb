require 'spec_helper'

describe "forums/index.html.erb" do
  before(:each) do
    assign(:forums, [
      stub_model(Forum),
      stub_model(Forum)
    ])
  end

  it "renders a list of forums" do
    render
  end
end
