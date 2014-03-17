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

  def lector
    #FIXME убрать UserDecorator.decorate, декорировать с помощью association
    UserDecorator.decorate model.user
  end

  def full_title
    "#{lector} - #{title}(#{model.workshop.title})"
  end
end
