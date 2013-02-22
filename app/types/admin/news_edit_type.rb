
class Admin::NewsEditType < News
  include BasicType

  validates :slug,  presence: true, uniqueness: true
  validates :title, presence: true
  validates :body,  presence: true
end
