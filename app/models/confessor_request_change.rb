class ConfessorRequestChange < ActiveRecord::Base
  belongs_to :diocese
  belongs_to :state
  belongs_to :confessor_request_status
  belongs_to :ConfessorRequest, inverse_of: :confessor_request_change
end
