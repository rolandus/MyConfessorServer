class ConfessionLocation < ActiveRecord::Base
  belongs_to :state, inverse_of: :confession_locations
  has_many :confession_location_changes, inverse_of: :confession_location
  has_many :confessors, inverse_of: :confession_location
  
  validates :name, :street_address, :city, :state, :postal_code, presence: true
  validates :name, :nickname, :city, :postal_code, length: { maximum: 64 }
  validates :street_address, length: { maximum: 512 }
end
