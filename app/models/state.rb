class State < ActiveRecord::Base
  has_many :dioceses
  has_many :confession_locations
end
