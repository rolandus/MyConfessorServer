class AccountStatus < ActiveRecord::Base
  has_many :user_accounts
  #has_many :user_account_changes  #Not needed, because when do we need to find all histories of a given status?
end
