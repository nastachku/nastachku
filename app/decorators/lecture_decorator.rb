# -*- coding: utf-8 -*-
class LectureDecorator < Draper::Decorator
  decorates :lecture
  decorates_association :user
  delegate_all

  def workshop_color_icon
    h.content_tag :span, class: 'icon_lectures icon_section',
                         style: "background-image: url(#{model.workshop.icon})" do
    end
  end

  def workshops_color_hash
    workshops = Workshop.all
    hash = { "#{workshops[0].title}" => "red", "#{workshops[1].title}" => "blue",
      "#{workshops[2].title}" => "orange", "#{workshops[3].title}" => "purple",
      "#{workshops[4].title}" => "green", "#{workshops[5].title}" => "yellow"}
    hash
  end

  def workshop_color
    "lecture__#{workshops_color_hash[model.workshop.title]}"
  end

  def lector
    #FIXME убрать UserDecorator.decorate, декорировать с помощью association
    UserDecorator.decorate model.user
  end

  def full_title
    "#{lector} - #{title}(#{model.workshop.title})"
  end
end
