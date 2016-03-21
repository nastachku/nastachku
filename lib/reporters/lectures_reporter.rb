class Reporters::LecturesReporter < Reporters::Base
  class << self
    def record_to_row(lecture)
      [
        lecture.title, lecture.state, lecture.user.full_name,
        lecture.user.city, lecture.user.company, lecture.user.email,
        lecture.user.phone, lecture.user.skype
      ]
    end

    def head
      [
        'Название доклада', 'Состояние доклада', 'ФИО докладчика',
        'город', 'компания', 'email', 'телефон', 'skype'
      ]
    end
  end
end
