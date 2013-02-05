
module BasicType
  extend ActiveSupport::Concern

  module ClassMethods
    def model_name
      superclass.model_name
    end

    def name
      superclass.name
    end
  end
end
