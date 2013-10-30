class UserAccount < ActiveRecord::Base
  belongs_to :account_status
  has_and_belongs_to_many :account_roles
  has_many :user_account_changes
end
