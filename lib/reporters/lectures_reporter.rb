class Reporters::LecturesReporter < Reporters::Base
  class << self
    def record_to_row(lecture)
      lecture_state = lecture.slot.present? ? 'В программе' : lecture.human_state_name

      [
        lecture.title, lecture_state, lecture.user.full_name,
        lecture.user.city, lecture.user.company, lecture.user.position,
        lecture.user.email, lecture.user.phone, lecture.user.skype
      ]
    end

    def head
      [
        'Название доклада', 'Статус доклада', 'Докладчик',
        'город', 'компания', 'должность', 'email', 'телефон', 'skype'
      ]
    end
  end
end
