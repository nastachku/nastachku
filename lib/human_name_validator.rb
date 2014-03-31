# coding: utf-8

class HumanNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^[a-zA-Zа-яА-ЯёЁ][a-zA-Zа-яА-ЯёЁ '`-]{0,253}[a-zA-Zа-яА-ЯёЁ]{0,1}$/
      record.errors.add(attribute, :human_name, options.merge(value: value))
    end
  end
end
