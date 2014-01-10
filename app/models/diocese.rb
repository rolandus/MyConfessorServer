class Diocese < ActiveRecord::Base
  belongs_to :state
  has_many :confessors
  has_many :confessor_changes
  has_many :confessor_requests
end
