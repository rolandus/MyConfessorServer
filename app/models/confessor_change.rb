class ConfessorChange < ActiveRecord::Base
  belongs_to :confessor, inverse_of: :confessor_changes
  belongs_to :confessor_office, inverse_of: :confessor_changes
  belongs_to :diocese, inverse_of: :confessor_changes
  belongs_to :user_account, inverse_of: :confessor_changes
  belongs_to :changed_by_user_account, :class_name => "UserAccount", inverse_of: :confessor_changes

  validates :changed_by_user_account, :confessor, presence: true
end
