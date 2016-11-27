class Reporters::UsersReporter < Reporters::Base
  class << self
    def record_to_row(user)
      [
        user.id, user.first_name, user.last_name, user.city,
        user.company, user.position, user.about,
        user.state, user.role,

        user.not_going_to_conference,
        user.show_as_participant, user.invisible_lector,
        user.in_carousel, user.carousel_info,

        user.sign_in_count,
        user.current_sign_in_at, user.current_sign_in_ip,
        user.last_sign_in_at, user.last_sign_in_ip,

        user.pay_state, user.ticket.try(:price),
        user.reason_to_give_ticket,

        user.badge_state, user.timepad_state,
        user.twitter_name, user.facebook, user.vkontakte
      ]
    end

    def head
      [
        han(:id), han(:first_name), han(:last_name), han(:city),
        han(:company), han(:position), han(:about),
        han(:state), han(:role),

        han(:not_going_to_conference),
        han(:show_as_participant), han(:invisible_lector),
        han(:in_carousel), han(:carousel_info),

        han(:sign_in_count),
        han(:current_sign_in_at), han(:current_sign_in_ip),
        han(:last_sign_in_at), han(:last_sign_in_ip),

        han(:pay_state), han(:price, Ticket),
        han(:reason_to_give_ticket),

        han(:badge_state), han(:timepad_state),
        han(:twitter_name), han(:facebook), han(:vkontakte)
      ]
    end

    private

    def han(attribute, klass = User)
      klass.human_attribute_name(attribute)
    end
  end
end
