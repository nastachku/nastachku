module BasicType
  extend ActiveSupport::Concern

  module ClassMethods
    def model_name
      superclass.model_name
    end

    def name
      superclass.name
    end

    def permit(*args)
      @_args = args
    end

    def _args
      @_args
    end
  end

  def assign_attributes(attrs = {}, options = {})
    raise ArgumentError, "expected hash" if attrs.nil?
    if attrs.kind_of?(ActionController::Parameters)
      permitted_attrs = attrs.send :permit, self.class._args
    else
      permitted_attrs = attrs.extract!(*self.class._args)
    end
    super(permitted_attrs)
  end
end
