# coding: utf-8

class CompanyNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^[a-zA-Zа-яА-ЯёЁ0-9 '`~\!@#\$\%\^\&\*\(\)_+=\-"\{\}\[\]\/\\|;:,.?<>]{0,255}$/
      record.errors.add(attribute, :company_name, options.merge(value: value))
    end
  end
end
