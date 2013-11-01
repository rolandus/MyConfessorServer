class UserAccountChange < ActiveRecord::Base
  belongs_to :user_account
  belongs_to :changed_by_user_account, :class_name => "UserAccount"
  belongs_to :account_status
end
