class Sponsors
  include ActiveSupport::Configurable

  class << self
    def method_missing(method)
      title_method = "#{method}_title".to_sym
      Hashie::Mash.new({
        title: self.config.send(title_method),
        list: self.config.send(method)
      })
    end
  end
end
