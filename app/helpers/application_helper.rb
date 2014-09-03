module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, { :sort => column, :direction => direction }, { :class => css_class }
  end

  def get_home_page(page)
    case page
    when 'home'
      'home.png'
    when 'army'
      'army.png'
    when 'war'
      'war.png'
    when 'structure'
      'structure.png'
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
