class UserLecturesEditType < User
  include BasicType

  permit :last_name, :first_name, :middle_name, :company, :position,
         :city, :phone, :email, :shirt_size, :skype,
         :photo, :about, lectures_attributes: [
           :id, :_destroy, :title, :thesises, :workshop_id, :presentation, :user_id
         ]

  validates :photo, presence: true
  validates :about, presence: true

  validates :last_name, :first_name, :middle_name, :company, :position,
            :city, :phone, :email, :shirt_size, presence: true

  validates_associated :lectures
end
