class ConfessionLocation < ActiveRecord::Base
  belongs_to :state
  has_many :confesstion_location_changes
end
