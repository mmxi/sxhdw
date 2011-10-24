require 'spec_helper'

describe Site do
  describe "validate site field" do
    [:name, :host, :description].each do |attr|
      it "validates presence of #{attr}" do
        subject.send("#{attr}=", nil)
        should_not be_valid
        subject.errors[attr].should be_present
      end
    end
  end
end
