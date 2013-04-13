module ApplicationHelper
  def page_header(text = t('.header'))
    "<div class='page-header'> <h3> #{ text } </h3> </div>".html_safe
  end

  def icon_label(classes, text = '', options = {})
    stringified_options = options.map { |key, value| "#{key.to_s}='#{value.to_s}'" }.join(' ')
    "<i class='#{ classes }' #{ stringified_options }></i> #{ text }".html_safe
  end

  def action_name
    super.inquiry
  end

  def controller_name
    super.inquiry
  end
end
