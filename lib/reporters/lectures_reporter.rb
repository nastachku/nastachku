class Reporters::LecturesReporter < Reporters::Base
  class << self
    def record_to_row(lecture)
      lecture_state = lecture.slot.present? ? 'В программе' : lecture.human_state_name

      [
        lecture.title, lecture_state, lecture.user.try(:full_name),
        lecture.user.try(:city), lecture.user.try(:company), lecture.user.try(:position),
        lecture.user.try(:email), lecture.user.try(:phone), lecture.user.try(:skype)
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
