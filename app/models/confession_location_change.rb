class ConfessionLocationChange < ActiveRecord::Base
  belongs_to :confession_location
  belongs_to :state
  belongs_to :user_account
end
