require 'spec_helper'

describe User do
  [:login, :email, :password, :password_confirmation].each do |attr|
    it "validates presence of #{attr}" do
      subject.send("#{attr}=", nil)
      should_not be_valid
      subject.errors[attr].should be_present
    end
  end

  describe "validate login field" do
    it "should be more than 4" do
      subject.login = "a" * 3
      should_not be_valid
      subject.errors[:login].should_not be_blank
    end
  end

  describe "validate password field" do
    it "password length is not less than 6" do
      subject.password = "a" * 5
      subject.password_confirmation = "a" * 5
      should_not be_valid
      subject.errors[:password].should_not be_blank
    end

    it "password must be equal password_confirmation" do
      subject.password = "a" * 6
      subject.password_confirmation = "b" * 6
      should_not be_valid
      subject.errors[:password].should_not be_blank
    end
  end

  describe "validate email field" do
    it "should be correct and uniqueness" do
      subject.email = "abc"
      should_not be_valid
      subject.errors[:email].should_not be_blank
      subject.email = "@163.com"
      should_not be_valid
      subject.errors[:email].should_not be_blank
      zhangsan = Factory.create(:zhangsan)
      subject.email = "zhangsan@gmail.com"
      should_not be_valid
      subject.errors[:email].should_not be_blank
    end
  end

  describe "User create" do
    it "should be create instance given factory object" do
      lambda {
        zhangsan = Factory.create(:zhangsan)
      }.should change{ User.count }.by(1)
    end
  end

  describe "User attributes update" do
    it "should not validate field" do
      zhangsan = Factory.create(:zhangsan)
      zhangsan.should be_valid
    end
  end

  describe "test function .find_by_login_or_email" do
    it "should find the user if login or mail is correct" do
      lambda {
        zhangsan = Factory.create(:zhangsan)
      }.should change{ User.count }.by(1)
      User.find_by_login_or_email("zhangsan").should_not be_nil
      User.find_by_login_or_email("zhangsan@gmail.com").should_not be_nil
    end
  end

  describe "test" do
    before do
      zhangsan = Factory.create(:zhangsan)
    end
    it "should do this" do
      pending
    end
  end
end