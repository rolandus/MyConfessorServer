class ConfessorRequestChange < ActiveRecord::Base
  belongs_to :diocese, inverse_of: :confessor_request_changes
  belongs_to :state, inverse_of: :confessor_request_changes
  belongs_to :confessor_request_status, inverse_of: :confessor_request_changes
  belongs_to :confessor_request, inverse_of: :confessor_request_changes
  belongs_to :changed_by_user_account, :class_name => "UserAccount", inverse_of: :confessor_request_changes
end
