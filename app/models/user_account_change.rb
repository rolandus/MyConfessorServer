class UserAccountChange < ActiveRecord::Base
  belongs_to :user_account
  belongs_to :account_status
end
