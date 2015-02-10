class FacebookAuthService
  class << self
    def register(auth_hash)
      attrs = user_attrs(auth_hash)
      authorization = Authorization.where(provider: auth_hash[:provider], uid: auth_hash[:uid])
                                   .first_or_initialize

      if authorization.persisted?
        user = authorization.user
      else
        user = UserFacebookType.where.not(email: nil)
                               .where(email: attrs[:email]).first_or_create(attrs)
        user.authorizations << authorization
      end

      if user.facebook.blank?
        user.facebook = attrs[:facebook]
        user.save
      end

      user
    end

    private
    def user_attrs(auth_hash)
      facebook_info = {
        first_name: auth_hash[:info][:first_name],
        last_name: auth_hash[:info][:last_name],
        photo: auth_hash[:info][:image],
        facebook: auth_hash[:info][:urls][:Facebook],
        email: auth_hash[:info][:email]
      }

      ActionController::Parameters.new facebook_info
    end
  end
end
