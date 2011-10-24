require 'spec_helper'

describe Topic do
  [:title, :site_id, :forum_id, :user_id].each do |attr|
    it "validates presence of #{attr}" do
      subject.send("#{attr}=", nil)
      should_not be_valid
      subject.errors[attr].should be_present
    end
  end

  it "creates topic by default" do
    forum = create_forum(:forum)
    topic = forum.topics.new
    topic.title = "绍兴在中国的哪里"
    topic.body = "content string"
    topic.sticky = nil
    topic.user = current_user
    topic.save

    Topic.last.should_not be_nil
    topic.posts.should == [Post.last]
  end

  def create_forum(name)
    @forum ||= current_site.forums.create(Factory.attributes_for(name))
  end
end
