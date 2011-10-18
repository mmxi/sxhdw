require 'spec_helper'

describe ApplicationHelper do
  describe "test #current_site" do
    context "when database empty" do
      it "should return new Site object" do
        pp current_site
      end
    end
  end
end