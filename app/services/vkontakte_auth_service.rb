class VkontakteAuthService
  class << self
    def register(auth_hash)
      attrs = user_attrs(auth_hash)
      authorization = Authorization.where(provider: auth_hash[:provider], uid: auth_hash[:uid])
                                   .first_or_initialize

      if authorization.persisted?
        user = authorization.user
      else
        user = UserVkontakteType.where(email: attrs[:email]).first_or_create(attrs)
        user.authorizations << authorization
      end

      # FIXME странная концепция с промо-кодами. Выпилить это, когда приведутся в порядок промо-коды
      User::PromoCode.create({ code: generate_promo_code, user_id: user.id }) unless user.promo_code

      user
    end

    private
    def user_attrs(auth_hash)
      vkontakte_info = {
        first_name: auth_hash[:info][:first_name],
        last_name: auth_hash[:info][:last_name],
        photo: auth_hash[:info][:image],
        vkontakte: auth_hash[:info][:urls][:Vkontakte],
        email: auth_hash[:info][:email]
      }

      ActionController::Parameters.new vkontakte_info
    end
  end
end
