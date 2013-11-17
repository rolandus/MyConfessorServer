class UserAccountChange < ActiveRecord::Base
  belongs_to :account_status
  belongs_to :user_account
  belongs_to :changed_by_user_account, :class_name => "UserAccount"
  has_one :confessor, inverse_of: :user_account_change
end
