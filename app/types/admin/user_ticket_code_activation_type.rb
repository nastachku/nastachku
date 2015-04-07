class Admin::UserTicketCodeActivationType
  include BasicTypeWithoutActiveRecord

  attribute :code, String

  validates :code, presence: true
  validate :existing_code, if: :code

  def existing_code
    ticket_code = TicketCode.find_by(code: code)
    if ticket_code
      unless ticket_code.new?
        errors.add(:code, :cant_activate)
      end
    else
      errors.add(:code, :code_not_exist)
    end
  end
end
