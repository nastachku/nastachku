class EventDecorator < Draper::Decorator
  delegate_all

  def full_title
    title
  end
end
