# -*- coding: utf-8 -*-
module ApplicationHelper
  include CustomUrlHelper
  include AuthHelper
  include WorkshopsColorHelper

  def copyright_notice_year_range(start_year)
    start_year = start_year.to_i
    current_year = Time.new.year
    if current_year > start_year && start_year > 2000
      "#{start_year} - #{current_year}"
    elsif start_year > 2000
      "#{start_year}"
    else
      "#{current_year}"
    end
  end

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

  def nl2br(content)
    lines = content.split(/\r\n/)
    render 'helpers/web/nl2br', lines: lines
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

  #FIXME запросы из хелпера - плохая идея. придумать другое решение.
  def new_lectures_count
    @new_lectures = Lecture.new_lectures.count
  end

  def is_main_page?
    request.path == root_path
  end

  def in_account?
    params[:controller] == 'web/accounts'
  end

  def current_user_not_going_to_conference?
    current_user.not_decided?
  end

  def current_user_attending_to_conference?
    current_user and current_user.paid_part?
  end
end
