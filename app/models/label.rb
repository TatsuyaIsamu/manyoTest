class Label < ApplicationRecord
  has_many :combinations, dependent: :destroy
  has_many :combination_tasks, through: :combinations, source: :task
end
