#encoding: utf-8
class Web::WelcomeController < Web::ApplicationController
  def index
    @lectures = LectureDecorator.decorate_collection Lecture.includes(:workshop, :user).scheduled.with_active_speaker.shuffle.first 30

    @meta_tags = {
      title: "«Стачка 2016», Международная IT-конференция в Ульяновске",
      description: "Официальный сайт ежегодной IT-конференции «Стачка»: Digital-коммуникации, Программирование, IT-стартапы, Электронная коммерция…",
      keywords: "Стачка IT-конференция"
    }
  end

  def landing
    render layout: 'web/promo'
  end
end
