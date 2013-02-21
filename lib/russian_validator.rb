# coding: utf-8

class RussianValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[а-я -]*\Z/iu
      record.errors.add(attribute, (options[:message] || :wrong_language))
    end
  end
end
