class AccountStatus < ActiveRecord::Base
  has_many :user_accounts, inverse_of: :account_status
  #has_many :user_account_changes  #Not needed, because when do we need to find all histories of a given status?
end
