class Diocese < ActiveRecord::Base
  belongs_to :state, inverse_of: :dioceses
  has_many :confessors, inverse_of: :diocese
  has_many :confessor_changes, inverse_of: :diocese
  has_many :confessor_requests, inverse_of: :diocese
  
  def name_and_state_abbr
    if self.state
      self.name + ', ' + self.state.abbreviation
    else
      self.name
    end
  end
end
