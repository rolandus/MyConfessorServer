class ConfessorChange < ActiveRecord::Base
  belongs_to :confessor_office
  belongs_to :user_account
  belongs_to :changed_by_user_account, :class_name => "UserAccount"
end
