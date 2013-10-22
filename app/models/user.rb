class User < ActiveRecord::Base
  has_many :user_locations, inverse_of: :user, dependent: :destroy
end
