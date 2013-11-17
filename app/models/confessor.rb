class Confessor < ActiveRecord::Base
  belongs_to :confessor_office
  belongs_to :confession_status
  belongs_to :confession_location
  belongs_to :user_account, inverse_of: :confessor
  belongs_to :user_account_change, inverse_of: :confessor
end
