# usage validates :name, russian: true

class RussianValidator < ActiveModel::Validator
  def validate_each(record, attribute, value)
    unless value =~ /\A[а-я -]+\Z/iu
      record.errors[attribute] << (options[:message] || :wrong_lang)
    end
  end
end
