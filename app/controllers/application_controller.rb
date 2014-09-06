class ApplicationController < ActionController::Base
  protect_from_forgery
  include StatsHelper
  before_filter :authenticate_user!
  helper_method :roundup

  def render404
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
    return true
  end

  def every_page
    update_collectors if current_user
  end

  def roundup(num)
    if num > 0
      x = Math.log10(num).floor
      (num/(10.0**x)).ceil * 10**x
    else
      0
    end
  end

  protected
  def authenticate_user!
    if user_signed_in?
      super
      every_page
    end
  end

end
