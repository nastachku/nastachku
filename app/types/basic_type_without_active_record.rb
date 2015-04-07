module BasicTypeWithoutActiveRecord
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations
    include ActiveModel::Conversion
    include ActiveModel::Translation
    include Virtus.model
  end

  def persisted?
    false
  end
end
