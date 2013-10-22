class ConfessionalLocation < ActiveRecord::Base
  belongs_to :user_locations, inverse_of: :confessional_locations
end
