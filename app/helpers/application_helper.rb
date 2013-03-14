module ApplicationHelper
  include AuthHelper
  include CustomUrlHelper

  def navbar_link(label, path, options = {})
    patch = options[:with]

    if patch
      label << " ("
      label << patch.to_s
      label << ")"
    end

    link_to label, path
  end

  def markdown(content)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    sanitized_content = sanitize content
    markdown.render(sanitized_content).html_safe
  end

  def filter(content)
    plain_text = strip_tags content
    plain_text.gsub(/\r\n/, '<br />').html_safe
  end

  def item(tag, name, path, link_options = {}, &block)
    options = {}
    options[:class] = :active if current_page?(path)
    link = link_to(name, path, link_options)
    content_tag(:li, link, options)
  end

end
