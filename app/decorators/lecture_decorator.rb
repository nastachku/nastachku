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
    workshops ||= Workshop.pluck(:title)
    colors = ["green", "yellow", "orange", "blue", "red", "purple"]
    pairs = workshops.zip colors
    hash = Hash[pairs]
    hash
  end

  def workshop_color
    color = workshop.color
    "lecture__#{color}"
  end

  def lector_photo
    lector.user_pic
  end

  def lector_name
    lector.full_name
  end

  def lector
    #FIXME убрать UserDecorator.decorate, декорировать с помощью association
    UserDecorator.decorate model.user
  end

  def full_title
    if model.user
      "#{lector} - #{model.title}(#{model.workshop.title})"
    else
      "#{model.title}(#{model.workshop.title})"
    end
  end

  def another_full_title
    if model.user
      "#{model.title}(#{lector.full_name})"
    else
      "#{model.title}"
    end
  end

  def lecture_votings_count
    model.lecture_votings.count
  end

  def by_id_url
    "#{h.lectures_url}?lecture_id=#{model.id}"
  end

  def user_lecture_by_id_url
    "#{h.user_lectures_url}?lecture_id=#{model.id}"
  end
end
