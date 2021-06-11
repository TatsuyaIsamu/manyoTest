class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy
  # validates :email, uniqueness: true
  before_destroy :admin_role_validation_destroy
  after_update :admin_role_validation_update
  has_many :labels, dependent: :destroy
  accepts_nested_attributes_for :labels
  def admin_role_validation_destroy
    if User.where(admin_role: :true).count == 1 && self.admin_role == true
      throw(:abort)
    end
  end
  def admin_role_validation_update
    if User.where(admin_role: :true).count == 0 && self.admin_role == false
      raise ActiveRecord::Rollback
    end
  end

  
end
