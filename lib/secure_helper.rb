module SecureHelper

  class << self
    def generate_token
      SecureRandom.urlsafe_base64
    end
  end

  def generate_promo_code
    Array.new(9){ rand(36).to_s(36) }.join
  end

end
