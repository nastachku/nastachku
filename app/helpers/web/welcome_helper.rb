module Web::WelcomeHelper
  def my_lectures(lectures)
    shorted_lectures = lectures.map do |lecture|
      lector = lecture.lector
      short_lecture = {
        id: lecture.id,
        title: lecture.title,
        thesises: lecture.thesises.first(140),
        workshop_icon: lecture.workshop.icon,
        lector: {
          id: lector.id,
          reverse_full_name: lector.reverse_full_name,
          position: lector.position,
          company: lector.company,
          user_pic: lector.assets_user_pic
        }
      }
    end
    shorted_lectures.to_json
  end
end
