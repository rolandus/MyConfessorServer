class ConfessorRequest < ActiveRecord::Base
  belongs_to :diocese, inverse_of: :confessor_requests
  belongs_to :state, inverse_of: :confessor_requests
  belongs_to :confessor_request_status, inverse_of: :confessor_requests
  belongs_to :user_account, inverse_of: :confessor_requests
  has_many :confessor_request_changes, inverse_of: :confessor_request


  #####################
  # Validations, etc...
  #####################
  
  validates :first_name, :last_name, :email, :diocese, :confessor_request_status, presence: true
  validates :first_name, :last_name, :email, length: { maximum: 64 }
  
  def full_name
    self.first_name + ' ' + self.last_name
  end
  
  def display_status
    case self.confessor_request_status_id
    when 1
      "created"
    when 2
      "pending"
    when 3
      "approved"
    else
      "denied"
    end
  end
  
  def is_created?
    self.confessor_request_status_id == 1
  end
  
  def is_pending?
    self.confessor_request_status_id == 2
  end

  def is_approved?
    self.confessor_request_status_id == 3
  end

  def is_denied?
    self.confessor_request_status_id == 4
  end

  def google_url
    url = "http://www.google.com/search?q="
    name = self.full_name.gsub(' ', '+')
    diocese = 'diocese+of+' + self.diocese.name.gsub(' ', '+')
    url + CGI::escape(name + '+' + diocese)
  end
end
