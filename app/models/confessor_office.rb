class ConfessorOffice < ActiveRecord::Base
  has_many :confessors, inverse_of: :confessor_office
  has_many :confessor_changes, inverse_of: :confessor_office
end
