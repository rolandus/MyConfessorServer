class AccountStatus < ActiveRecord::Base
  has_many :user_accounts, inverse_of: :account_status
  has_many :user_account_changes, inverse_of: :account_status
end
