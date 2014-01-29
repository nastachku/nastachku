class UserDecorator < Draper::Decorator
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

end
