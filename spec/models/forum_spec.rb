require 'spec_helper'
require 'google_translate'

describe Forum do

  [:name, :site_id].each do |attr|
    it "requires #{attr}" do
      subject.send("#{attr}=", nil)
      should_not be_valid
      subject.errors[attr].should be_present
    end
  end

  it "creates a forum" do
    @forum = create_forum(:forum)
    @forum.save
    current_site.forums.should == [@forum]
  end

  def create_forum(name)
    @forum ||= current_site.forums.create(name)
  end
end
