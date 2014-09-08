module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, { :sort => column, :direction => direction }, { :class => css_class }
  end

  def get_home_page(page)
    @one = "background-repeat: no-repeat"
    @percentage = "background-position: 0% 0%"
    @opt1 = ""
    case page
    when 'home'
      @filename = 'homescreen.jpg'
      # @percentage = "background-position: 90% 10%"
      @opt1 = "background-size: 95%; background-repeat: no-repeat; background-attachment: fixed;"
      when 'army'
      'army.png'
    when 'war'
      'war.png'
    when 'structures'
      @filename = 'structures.jpg'
      # @percentage = "background-position: 90% 10%"
      @opt1 = "background-size: 95%; background-repeat: no-repeat; background-attachment: fixed;"
      when 'market'
      'market.png'
    when 'spells'
      'spells.png'
    when 'items'
      'items.png'
    when 'notification'
      'notifications.png'
    end
  end

end
