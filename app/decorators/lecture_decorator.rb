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

  def workshop_color
    workshops = Workshop.all
    hash = { "#{workshops[0].title}" => "lecture__red", "#{workshops[1].title}" => "lecture__blue",
      "#{workshops[2].title}" => "lecture__orange", "#{workshops[3].title}" => "lecture__purple",
      "#{workshops[4].title}" => "lecture__green", "#{workshops[5].title}" => "lecture__yellow"}
    hash[model.workshop.title]
  end

  def lector
    #FIXME убрать UserDecorator.decorate, декорировать с помощью association
    UserDecorator.decorate model.user
  end

  def full_title
    "#{lector} - #{title}(#{model.workshop.title})"
  end
end
