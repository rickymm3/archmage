module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, { :sort => column, :direction => direction }, { :class => css_class }
  end

  def get_home_page(page)
    @one = "background-repeat: no-repeat"
    @percentage = "background-position-x: 120%; background-position-y: 0%;background-position: 90% 10% "
    @opt1 = "background-repeat: no-repeat;"

    case page
    when 'home'
      @filename = 'homescreen.jpg'
      @percentage = "background-position: 90% 20%"
    when 'army'
      @filename = 'army.jpg'
      @percentage = "background-position: 50% 80%"
    when 'war'
      @filename = 'homescreen.jpg'
      @percentage = "background-position: 90% 20%"

    when 'structures'
      @filename = 'structures.jpg'
      @percentage = "background-position: 90% 60%"

    when 'market'
      @filename = 'homescreen.jpg'
      @percentage = "background-position: 90% 20%"

    when 'spells'
      @filename = 'homescreen.jpg'
      @percentage = "background-position: 90% 20%"

    when 'items'
      @filename = 'homescreen.jpg'
      @percentage = "background-position: 90% 20%"

    when 'notification'
      @filename = 'homescreen.jpg'
      @percentage = "background-position: 90% 20%"

    when 'morale'
      @filename = 'homescreen.jpg'
      @percentage = "background-position: 90% 20%"

    end
  end

end
