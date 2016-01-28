class Sponsors
  include ActiveSupport::Configurable

  class << self
    def method_missing(method)
      self.config.send(method)
    end
  end
end
