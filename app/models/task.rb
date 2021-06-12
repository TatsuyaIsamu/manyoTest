class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum priority: [:高, :中, :低]
  scope :searching, -> (params) {where("content LIKE ? or title LIKE ?", "%#{params}%", "%#{params}%")}
  scope :statusing, -> (params) {where(status: params)}
  belongs_to :user
  has_many :combinations, dependent: :destroy
  has_many :labels, through: :combinations, source: :label
  
end
