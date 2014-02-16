class ConfessorRequestStatus < ActiveRecord::Base
  has_many :confessor_requests, inverse_of: :confessor_request_status
  
  def display_verb
    case self.confessor_request_id
    when 1
      "pend"
    when 2
      "approve"
    when 3
      "deny"
    end
  end
end
