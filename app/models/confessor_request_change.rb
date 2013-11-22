class ConfessorRequestChange < ActiveRecord::Base
  belongs_to :diocese
  belongs_to :state
  belongs_to :confessor_request_status
  belongs_to :confessor_request, inverse_of: :confessor_request_changes
  belongs_to :changed_by_user_account, :class_name => "UserAccount"
end
