class Label < ApplicationRecord
  has_many :combinations, dependent: :destroy
  has_many :tasks, through: :combinations, source: :task
end
