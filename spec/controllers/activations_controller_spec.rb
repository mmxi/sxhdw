require 'spec_helper'

describe ActivationsController do

  describe "GET 'create'" do
    before(:each) do
      @user = Factory.create(:zhangsan)
    end

    context "when user don't active and user exist'" do
      it "should be successful" do
        User.stub(:find_using_perishable_token).and_return(@user)
        get :create, :activation_code => "abcdefg"
        @user.reload
        @user.active.should be_true
        flash[:success].should_not be_nil
        response.should redirect_to user_path(@user)
      end
    end

    context "when user don't exist" do
      it "should be failure" do
        User.stub(:find_using_perishable_token).and_return(nil)
        get :create, :activation_code => "abcdefg"
        response.should redirect_to root_path
      end
    end
  end

end
