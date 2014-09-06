class ApplicationController < ActionController::Base
  protect_from_forgery
  include StatsHelper
  before_filter :every_page
  helper_method :roundup

  def render404
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
    return true
  end

  def every_page
    update_collectors if current_user
    complete_explore if current_user.explore_end - Time.now < 0 && current_user.is_exploring?
  end

  def roundup(num)
    if num > 0
      x = Math.log10(num).floor
      (num/(10.0**x)).ceil * 10**x
    else
      0
    end
  end

end
