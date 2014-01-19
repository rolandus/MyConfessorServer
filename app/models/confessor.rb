class Confessor < ActiveRecord::Base
  belongs_to :confessor_office, inverse_of: :confessors
  belongs_to :diocese, inverse_of: :confessors
  belongs_to :confession_status, inverse_of: :confessors
  belongs_to :confession_location, inverse_of: :confessors
  belongs_to :user_account, inverse_of: :confessor
  belongs_to :user_account_change, inverse_of: :confessors
  
  has_many :confessor_changes, inverse_of: :confessor
  
  validates :confessor_office, :diocese, :user_account, :confession_status, presence: true
  validates :salutation, length: { maximum: 64 }

  def full_name
    user_account.first_name + ' ' + user_account.last_name
  end
end
