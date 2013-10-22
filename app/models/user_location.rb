class UserLocation < ActiveRecord::Base
  belongs_to :user, inverse_of: :user_locations
  has_one :confessional_location, inverse_of: :user_location
end
