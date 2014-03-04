class ConfessionLocationChange < ActiveRecord::Base
  belongs_to :confession_location, inverse_of: :confession_location_changes
  belongs_to :state, inverse_of: :confession_location_changes
  belongs_to :diocese, inverse_of: :confession_location_changes
  belongs_to :user_account, inverse_of: :confession_location_changes
  
  validates :user_account, :confession_location, presence: true
end
