module ApplicationHelper
end

class String
  def icon(size = 24)
    "<i class=\"material-icons md-#{size}\">#{self}</i>".html_safe
  end
end

class Symbol
  def icon(size = 24)
    "<i class=\"material-icons md-#{size}\">#{self}</i>".html_safe
  end
end
