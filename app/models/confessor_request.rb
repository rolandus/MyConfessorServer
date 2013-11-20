class ConfessorRequest < ActiveRecord::Base
  belongs_to :diocese
  belongs_to :state
  belongs_to :confessor_request_status
  has_many :confessor_request_changes, inverse_of: :confessor_request
end
