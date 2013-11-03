class Confessor < ActiveRecord::Base
  belongs_to :confessor_office
  belongs_to :confession_status
  belongs_to :confession_location
  has_one :user_account
end
