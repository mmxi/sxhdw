require 'spec_helper'

describe TopicsController do
  before(:each) do
    @postparams = {:title => "topic title", :body => "aa bb ccc[em:sorry]"}
  end

  it "should create a topic by @postparams" do
    @forum = create_forum(:forum)
    controller.stub(:current_site).and_return(current_site)
    controller.stub(:current_user).and_return(current_user)
    post :create, :forum_id => @forum.to_param, :topic => @postparams
    Topic.last.should_not be_nil
    Topic.last.posts.should == [Post.last]
    Post.last.body_html.should == "<p>aa bb ccc<img src=\"/images/mantou/sorry.png\" alt=\"sorry\" /></p>"
    response.should redirect_to forum_topic_path(@forum, Topic.last)
  end

  it "should replace smiles" do
    #text = "This is *my* text."
    #puts RedCloth.new(text).to_html
    #puts text
    
    #r = RedCloth.new
    #puts r.refs_smiley("You're so silly! [em:sorry][em:happy] [em:cry] ~:happy")
  end

  def create_forum(name)
    @forum ||= current_site.forums.create(Factory.attributes_for(name))
  end
end
