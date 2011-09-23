require 'spec_helper'

describe User do
  before :each do
    @zhangsan = Factory.build(:zhangsan)
    @zhangsan = Factory.create(:zhangsan)
    @zhangsan = Factory(:zhangsan)
  end
end
