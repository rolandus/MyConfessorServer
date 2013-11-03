class UserAccount < ActiveRecord::Base
  belongs_to :account_status
  belongs_to :confessor
  has_and_belongs_to_many :account_roles
  has_many :user_account_changes #TODO - double-check that this is using the user id and not the editing user id
end
