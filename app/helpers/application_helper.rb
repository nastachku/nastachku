module ApplicationHelper
  include CustomUrlHelper
  include AuthHelper
  include WorkshopsColorHelper

  def markdown(content)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    sanitized_content = sanitize content
    markdown.render(sanitized_content).html_safe
  end

  def dropdown(args)
    render 'helpers/web/dropdown', name: args[:name], items: args[:items]
  end

  def item(tag, name, path, link_options = {}, &block)
    options = {}
    options[:class] = :active if current_page?(path)
    link = link_to(name, path, link_options)
    content_tag(:li, link, options)
  end

  def asset_url asset
    "#{request.protocol}#{request.host_with_port}#{asset_path(asset)}"
  end

  def current_user_decorate
    current_user.decorate
  end

  def is_main_page?
    request.path == root_path
  end

  def in_account?
    params[:controller].include?('web/account')
  end

  def link_to_tel(phone)
    link_to phone, "tel:#{phone}"
  end

  def price_format(price)
    price.to_i
  end

  def meta_tags
    if @meta_tags
      names = @meta_tags.keys

      names.each do |name|
        @meta_tags["og:#{name}"] = @meta_tags[name]
      end

      @meta_tags
    else
      {}
    end
  end

  def custom_title
    meta_tags_title = @meta_tags && @meta_tags[:title]
    meta_tags_title || "Стачка!"
  end

  def render_sponsors(sponsors)
    return if sponsors.blank?

    sponsor_templates = sponsors.shuffle.map do |sponsor|
      render 'layouts/web/shared/sponsor', sponsor
    end

    sponsor_templates.reduce(&:+)
  end
end
