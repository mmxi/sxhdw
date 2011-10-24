require 'spec_helper'

describe Setting::UsersController do
  render_views
  
  def current_site
    @current_site ||= Factory.create(:site)
  end

  describe "GET #edit" do
    before(:each) do
      @user = current_site.users.create(Factory.attributes_for(:zhangsan))
      controller.stub!(:current_user).and_return(@user)
    end
    
    it "should be successful" do
      get :edit, :id => @user.id
      assigns[:user].should_not be_nil
      response.should be_success
      response.should render_template("edit")
    end
  end

  describe "PUT #update" do
    before(:each) do
      @user = current_site.users.create(Factory.attributes_for(:zhangsan))
      controller.stub!(:current_user).and_return(@user)
    end

    it "should update user record" do
      put :update, {:user => {:nickname => "aliang"}}
      User.last.nickname.should == "aliang"
    end
  end
end
