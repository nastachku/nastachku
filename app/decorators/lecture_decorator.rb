class LectureDecorator < Draper::Decorator
  delegate_all

  def workshop_color_icon
    h.content_tag :span, class: 'icon_lectures icon_section',
                         style: "background-image: url(#{model.workshop.icon})" do
    end
  end

end
