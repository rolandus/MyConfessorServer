class Confessor < ActiveRecord::Base
  belongs_to :confessor_office, inverse_of: :confessors
  belongs_to :diocese, inverse_of: :confessors
  belongs_to :confession_status, inverse_of: :confessors
  belongs_to :confession_location, inverse_of: :confessors
  belongs_to :user_account, inverse_of: :confessor
  belongs_to :user_account_change, inverse_of: :confessors
  
  has_many :confessor_changes, inverse_of: :confessor
  
  validates :confessor_office, :diocese, :user_account, :confession_status, presence: true
  validates :salutation, length: { maximum: 64 }

  def full_name
    self.user_account.full_name
  end
  
  def first_name
    self.user_account.first_name
  end
  
  def last_name
    self.user_account.last_name
  end
  
  def full_name_address
    case self.confessor_office_id
    when 1
      return "Pope " + self.first_name
    when 2
      return self.first_name + " Card. " + self.last_name
    when 3
      return "Abp. " + self.full_name
    when 4
      return "Ep. " + self.full_name
    else
      return "Fr. " + self.full_name
    end  
  end
  
  def last_name_address
    case self.confessor_office_id
    when 1 #Pope
      return "His Holiness"
    when 2 #Cardinal
      return "Cardinal " + self.last_name
    when 3 #Archbishop
      return "Archbishop " + self.last_name
    when 4 #Bishop
      return "Bishop " + self.last_name
    else   #Priest
      return "Father " + self.last_name
    end  
  end
  
  def informal_address
    if self.salutation.length > 0
      return self.salutation
    else
      return self.last_name_address
    end
  end
  
  def status_for_display
    case self.confession_status_id
    when 1
      return "IN"
    when 2
      return "BUSY"
    else
      return "OUT"
    end  
  end
  
  def available?
    return self.confession_status_id == 1
  end
  
  def busy?
    return self.confession_status_id == 2
  end
  
  def in?
    return self.available? || self.busy?
  end
  
  def out?
    return self.confession_status_id == 3
  end
end
