class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{source.last_name} #{source.first_name}"
  end

  def reverse_full_name
    "#{source.first_name} #{source.last_name}"
  end
end
