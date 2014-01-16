class ConfessorOffice < ActiveRecord::Base
  has_many :confessors, inverse_of: :confessor_office
end
