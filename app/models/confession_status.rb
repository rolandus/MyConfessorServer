class ConfessionStatus < ActiveRecord::Base
  has_many :confessors, inverse_of: :confession_status
end
