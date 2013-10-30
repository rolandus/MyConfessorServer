class AccountStatus < ActiveRecord::Base
  has_many :user_accounts
end
