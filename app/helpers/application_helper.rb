module ApplicationHelper

  def page_title(title)
    default_title = "Hyra"
    if title.empty?
      default_title
    else
      "#{title}"
    end
  end

  def real_current_user?(user)
    current_user == user ? true : false
  end

  #This allows registration to be placed anywhere in the views
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  #Create messages in any views
  def message
    @message ||= Message.new
  end
end
