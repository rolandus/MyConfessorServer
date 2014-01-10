class UserAccount < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #, :validatable  *rscott - Got rid of this so we can save the UserAccount form.
  belongs_to :account_status, inverse_of: :user_accounts
  has_one :confessor, inverse_of: :user_account
  has_and_belongs_to_many :account_roles
  has_many :user_account_changes, inverse_of: :user_account  #TODO - double-check that this is using the user id and not the editing user id
end
