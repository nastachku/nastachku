# coding: utf-8

class RussianValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[а-я -]+\Z/iu
      record.errors[attribute] << (options[:message] || "Поле должно содержать только русские буквы")
    end
  end
end
