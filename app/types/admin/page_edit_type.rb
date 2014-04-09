
class Admin::PageEditType < Page
  include BasicType

  validates :slug,  presence: true, uniqueness: true
  validates :title
  validates :body,  presence: true
end
