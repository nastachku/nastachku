class Admin::TicketCodeActivationType
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus.model

  attribute :id, Integer
  attribute :user_id, Integer
  attribute :first_name, String
  attribute :last_name, String
  attribute :email, String
  attribute :ticket_code, TicketCode

  validates :ticket_code, presence: true
  validates :user_id, presence: true, if: :without_new_user_data?
  validates :first_name, :last_name, presence: true, unless: 'user_id.present?'
  validate :user_without_ticket, if: 'user_id.present?'

  def without_new_user_data?
    !(first_name.present? && last_name.present?)
  end

  def user_without_ticket
    user = User.find(user_id)
    case ticket_code.kind
    when 'party'
      if user.afterparty_ticket
        errors.add(:user_id, :user_already_has_ticket)
      end
    when 'conference'
      if user.ticket
        errors.add(:user_id, :user_already_has_ticket)
      end
    end
  end

  def as_activation_params
    {
      user_id: user_id,
      first_name: first_name,
      last_name: last_name,
      email: email,
      code: ticket_code.code
    }
  end

end
