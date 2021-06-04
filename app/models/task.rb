class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  scope :searching, -> (params) {where("content LIKE ? or title LIKE ?", "%#{params}%", "%#{params}%")}
  scope :statusing, -> (params) {where(status: params)}
end
