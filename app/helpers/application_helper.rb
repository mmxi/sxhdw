module ApplicationHelper
  def get_oauth_user_image(oauth)
    provider = oauth["provider"]
    user_image = "" 
    if provider == "qzone"
      user_image = oauth["user_info"]["urls"]["figureurl_1"]
    elsif provider == "tqq"
      user_image = oauth["user_info"]["image"] + "/50"
    else
      user_image = oauth["user_info"]["image"]
    end
    user_image
  end
end
