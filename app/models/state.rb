class State < ActiveRecord::Base
  has_many :dioceses, inverse_of: :state
  has_many :confessor_requests, inverse_of: :state
  has_many :confession_locations, inverse_of: :state
end
