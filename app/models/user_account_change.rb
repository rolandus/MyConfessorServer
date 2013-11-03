class UserAccountChange < ActiveRecord::Base
  belongs_to :user_account
  belongs_to :account_status
  belongs_to :confessor
  belongs_to :changed_by_user_account, :class_name => "UserAccount"
end
