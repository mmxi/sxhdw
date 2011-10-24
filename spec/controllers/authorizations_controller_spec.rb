require 'spec_helper'

describe AuthorizationsController do
  describe "oauth login redirect callback" do
    context "when user already login in, but have't bind to oauth" do
      before(:each) do
        @user = Factory.create(:zhangsan)
        controller.stub!(:current_user).and_return(@user)
        OmniAuth.config.mock_auth[:tsina] = {'provider' => "tsina", 'uid' => "123456"}
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:tsina]
        Authorization.stub!(:find_from_hash).and_return(nil)
      end
      it "should bind user, redirect to user_path, and notice user" do
        get :create
        flash[:notice].should == "#{@user.display_name}，你的帐号已经成功绑定到#{I18n.t('oauth.' + request.env['omniauth.auth']['provider'])}"
        response.should be_success
        assigns[:redirect_to].should == user_path(@user)
        Authorization.last.provider.should == request.env['omniauth.auth']['provider']
      end
    end
    context "when user hasn't login in, but already bind to oauth" do
      before(:each) do
        @user = Factory.create(:zhangsan)
        controller.stub!(:current_user).and_return(nil)
        OmniAuth.config.mock_auth[:tsina] = {'provider' => "tsina", 'uid' => "123456"}
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:tsina]
        @auth = @user.authorizations.create(:provider => "tsina", :uid => "123456")
        Authorization.stub!(:find_from_hash).and_return(@auth)
      end
      it "should login success with oauth user" do
        get :create
        flash[:notice].should == "欢迎回来，你正在使用#{I18n.t('oauth.' + request.env['omniauth.auth']['provider'])}登录绍兴活动网"
        assigns[:redirect_to].should == user_path(@user)
      end
    end
    context "when user hasn't login in and hasn't bind to oauth" do
      before(:each) do
        controller.stub!(:current_user).and_return(nil)
        OmniAuth.config.mock_auth[:tsina] = {'provider' => "tsina", 'uid' => "123456"}
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:tsina]
        Authorization.stub!(:find_from_hash).and_return(nil)
      end
      it "should assings redirect to user_bind_path" do
        get :create
        session[:omniauth].should == request.env['omniauth.auth']
        assigns[:redirect_to].should == user_login_path
      end
    end
  end
end