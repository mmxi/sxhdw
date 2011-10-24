require 'spec_helper'

describe UsersController do
  describe "GET #new" do
    context "when anonymous user access" do
      it "should be success" do
        get :new
        assigns[:user].should_not be_nil
        assigns[:user].should be_new_record
        response.should be_success
        response.should render_template("new")
      end
    end
  end

  describe "POST #create" do
    before(:each) do
      controller.stub(:current_site).and_return(current_site)
      @post_params = {:user => Factory.attributes_for(:wangwu)}
    end

    it "should save post_params to database" do
      post :create, @post_params
      User.last.login.should == "wangwu"
      current_site.users.should == [User.last]
    end

    context "when save successful" do
      it "should redirect to signup_path" do
        post :create, @post_params
        flash[:notice].should_not be_nil
        response.should redirect_to(signup_path)
      end
    end

    context "when failure" do
      it "should render new action" do
        post :create, {:user => {:login => "test"}}
        flash[:error].should_not be_nil
        response.should render_template("new")
      end
    end

    context "user already login in" do
      before(:each) do
        @user = current_site.users.create(Factory.attributes_for(:wangwu))
        controller.stub!(:current_user).and_return(@user)
      end

      it "should redirect to user_path" do
        post :create
        response.should redirect_to user_path(@user)
      end
    end
  end

  describe "PUT #update" do
    before(:each) do
      @user = Factory.create(:zhangsan)
      controller.stub!(:current_user).and_return(@user)
    end
    it "should update user record" do
      put :update, {:user => {:nickname => "StevenWang"}}
      @user.reload
      flash[:success].should_not be_nil
      User.last.nickname.should == "StevenWang"
    end
    context "when file is a picture" do
      it "should be successful" do
        put :update, @attr = {:user => {:photo => File.new(Rails.root + 'spec/fixtures/images/rails.png')}}
        User.last.photo_file_name.should == "rails.png"
        flash[:success].should_not be_nil
        response.should redirect_to edit_user_path(@user)
      end
    end
    context "when file is not a picture" do
      it "should be failure" do
        put :update, @attr = {:user => {:photo => File.new(Rails.root + 'spec/fixtures/images/test.txt')}}
        @user.errors[:photo_content_type].should_not be_nil
        flash[:error].should_not be_nil
        response.should redirect_to edit_user_path(@user)
      end

    end

  end

  describe "PUT #change_password" do
    before(:each) do
      @user = Factory.create(:zhangsan)
      controller.stub!(:current_user).and_return(@user)
      @post_params1 = {:user => {:password => "aaaaaa", :password_confirmation => "aaaaaa"}}
      @post_params2 = {:user => {:password => "123456", :password_confirmation => "111111"}}
      @post_params3 = {:user => {:password => "", :password_confirmation => ""}}
    end
    context "when password is equal to password_confirmation" do
      it "should be successfual" do
        put :change_password, @post_params1
        flash[:success].should_not be_nil
      end
    end
    context "when password is not equal to password_confirmation" do
      it "should be failure" do
        put :change_password, @post_params2
        flash[:error].should_not be_nil
      end
    end
    context "when password is blank" do
      it "should be failure" do
        put :change_password, @post_params3
        flash[:error].should_not be_nil
      end
    end
  end

  describe "GET #login" do
    context "when user access this page without omniauth" do
      before(:each) do
        session[:omniauth] = nil
      end
      it "should redirect root_path" do
        get :login
        response.should redirect_to root_path
      end
    end
  end

  describe "POST #login" do
    context "when user access this page with omniauth" do
      before(:each) do
        @user = Factory.create(:wangwu)
        @omniauth = {'provider' => "tsina", 'uid' => "123456", 'user_info' => {'name' => 'StevenWang', 'image' => 'rails.png'}}
        session[:omniauth] = @omniauth
        @post_params = {:user => {:nickname => "张三", :login => "zhangsan", :email => "zhangsan@163.com"}}
      end
      it "should create new user record" do
        controller.stub(:get_oauth_user_image).and_return("rails.png")
        post :login, @post_params
        User.last.nickname.should == @post_params[:user][:nickname]
        User.last.face_url.should_not be_nil
        User.last.active.should be_true
        Authorization.last.user.should == User.last
        Authorization.last.image.should_not be_nil
        flash[:notice].should == "欢迎#{I18n.t('oauth.' + @omniauth['provider'])}用户，你的帐号创建成功"
        session[:omniauth].should be_nil
        response.should redirect_to user_path(User.last)
      end
    end
    context "when user exist" do
      before(:each) do
        @user = Factory.create(:zhangsan)
        session[:omniauth] = {'provider' => "tsina", 'uid' => "123456", 'user_info' => {'name' => 'StevenWang', 'image' => 'rails.png'}}
        @post_params = {:user => {:nickname => "张三", :login => "zhangsan", :email => "zhangsan@163.com"}}
      end
      it "should redirect to user_login_path" do
        post :login, @post_params
        flash[:error].should == "请检查你的输入是否正确，可能该帐号已经存在"
        response.should redirect_to user_login_path
      end
    end
  end

  describe "GET #bind" do
    context "when user access this page without omniauth" do
      before(:each) do
        session[:omniauth] = nil
      end
      it "should redirect root_path" do
        get :login
        response.should redirect_to root_path
      end
    end
  end

  #describe "POST #bind" do
  #  context "when user post login and password are correct" do
  #    before(:each) do
  #      @user = Factory.create(:zhangsan)
  #      @omniauth = {'provider' => "tsina", 'uid' => "123456", 'user_info' => {'name' => 'StevenWang', 'image' => 'rails.png'}}
  #      session[:omniauth] = @omniauth
  #      @post_params = {:user_session => {:login => "zhangsan", :password => "123456"}}
  #    end
  #    it "should login success" do
  #      controller.stub!(:get_oauth_user_image).and_return("rails.png")
  #      assigns[:user_session].stub!(:save).and_return(true)
  #      post :bind, @post_params
  #      response.should redirect_to user_path(@user)
  #    end
  #  end
  #end
end