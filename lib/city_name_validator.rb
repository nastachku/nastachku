# coding: utf-8

class CityNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^[a-zA-Zа-яА-ЯёЁ0-9 '`-]{0,255}$/
      record.errors.add(attribute, :city_name, options.merge(value: value))
    end
  end
end
