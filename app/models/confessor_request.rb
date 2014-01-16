class ConfessorRequest < ActiveRecord::Base
  belongs_to :diocese, inverse_of: :confessor_requests
  belongs_to :state, inverse_of: :confessor_requests
  belongs_to :confessor_request_status, inverse_of: :confessor_requests
  has_many :confessor_request_changes, inverse_of: :confessor_request

  validates :first_name, :last_name, :email, :diocese, :confessor_request_status, presence: true
  validates :first_name, :last_name, :email, length: { maximum: 64 }
end
