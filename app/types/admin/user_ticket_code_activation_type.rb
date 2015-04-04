class Admin::UserTicketCodeActivationType
  include BasicTypeWithoutActiveRecord

  attribute :code, String

  validates :code, presence: true
end
