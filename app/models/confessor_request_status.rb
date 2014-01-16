class ConfessorRequestStatus < ActiveRecord::Base
  has_many :confessor_requests, inverse_of: :confessor_request_status
end
