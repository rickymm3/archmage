class UserNotification < ActiveRecord::Base
  belongs_to :notification
  belongs_to :user
  def self.render_message(un, user)
    un.update_attributes(viewed: true)
    n = Notification.find(un.notification_id)
    vars = {"user" => user.username, "num1" => un.num1, "num2" => un.num2, "num3" => un.num3,
            "num4" => un.num4,
            "num5" => un.num5,
            "date1" => un.date1,
            "date2" => un.date2,
            "date3" => un.date3,
            "str1" => un.str1,
            "str2" => un.str2,
            "str3" => un.str3,
    }
    # convert_dates(vars)
    n.message.gsub(/\w+/) { |m| vars.fetch(m,m)}
  end

end
