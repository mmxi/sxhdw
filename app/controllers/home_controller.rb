class HomeController < ApplicationController
  def index
  end
  
  def testajax
    respond_to do |wants|
      wants.js
    end
  end

end
