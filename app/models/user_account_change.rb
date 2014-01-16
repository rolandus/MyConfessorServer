class UserAccountChange < ActiveRecord::Base
  belongs_to :account_status, inverse_of: :user_account_changes
  belongs_to :user_account, inverse_of: :user_account_changes
  belongs_to :changed_by_user_account, :class_name => "UserAccount", inverse_of: :user_account_changes
  has_one :confessor, inverse_of: :user_account_change
end
