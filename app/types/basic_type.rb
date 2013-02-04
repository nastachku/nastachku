
module BasicType
  extend ActiveSupport::Concern

  module ClassMethods
    def model_name
      superclass.model_name
    end
  end
end
