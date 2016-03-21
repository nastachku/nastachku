class Reporters::LecturesReporter < Reporters::Base
  class << self
    def record_to_row(lecture)
      [lecture.id, lecture.user.id, lecture.title]
    end

    def head
      ['Nothing', 'is', 'here']
    end
  end
end
