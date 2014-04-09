
class Admin::PageEditType < Page
  include BasicType

  validates :slug,  presence: true, uniqueness: true
  validates :body,  presence: true
end
