class UserDecorator < Draper::Decorator
  decorates :user
  delegate_all

  def full_name
    "#{model.last_name} #{model.first_name}"
  end

  def reverse_full_name
    "#{model.first_name} #{model.last_name}"
  end

  def to_s
    full_name
  end

  def lector_section_color
    if main_lecture and main_lecture.workshop
      h.content_tag :span, class: 'icon_mainsection icon_section',
                           style: "background-image: url(#{main_lecture.workshop.icon})" do
      end
    end
  end

  def main_lecture
    model.lectures.voted_or_scheduled.first
  end

  def user_pic
    if model.photo.present?
      model.photo
    else
      "default-user-image.png"
    end
  end

end
