class ConfessorChange < ActiveRecord::Base
  belongs_to :confessor_office
  belongs_to :user_account
end
