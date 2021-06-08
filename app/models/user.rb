class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy

  before_destroy :admin_role_validation_destroy
  after_update :admin_role_validation_update

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
