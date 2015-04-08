module Concerns::NormalizeBlankValues
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_blank_values
    before_save :normalize_blank_values
  end

  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end
end
