class UserAccount < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :account_status, inverse_of: :user_accounts  
  has_one :confessor, inverse_of: :user_account
  has_and_belongs_to_many :account_roles
  
  # Association for changes to this UserAccount (NOT changes *made* by this UserAccount)
  has_many :user_account_changes, inverse_of: :user_account
  #TODO - Figure out how to make the association to the changes *made* by this UserAccount
  
  # Association for changes to a Confessor *made* by this user account
  has_many :confessor_changes, inverse_of: :user_account
  
  # Association for changes to a ConfessorRequest made by this user account
  has_many :confessor_request_changes, inverse_of: :user_account
  
  validates :first_name, :last_name, :account_status, presence: true
  validates :first_name, :last_name, :email, :home_phone, :work_phone, :mobile_phone, length: { maximum: 64 }
  # I assume the Devise fields are validated in the Devise code (see :validatable) 
  
  validates_associated :confessor  #Make sure the associated confessor is valid. (I'm assuming this only happens if it's non-null)
  
  # Allows the following patterns:
  # (715)437-0956
  # (715) 437-0956
  # 715-437-0956
  # 715 437-0956
  # 7154370956
  validates :home_phone, :mobile_phone, :work_phone, allow_blank: true, format: { with: /((\(\d{3}\) ?|\d{3}(\-| ))\d{3}\-\d{4})|(\d{10})/ }
  
  before_save :normalize_phone_numbers, :trim_strings  # Can't use after_validate here, because it affects what gets sent in the formstate.
  
  #############
  # Utilities
  #############

  # Returns true if this user is an admin or superadmin
  def is_admin
    self.account_role_ids.min <= 2
  end
  
  # Returns true only if this user is a superadmin
  def is_superadmin
    self.account_role_ids.include? 1
  end
  
  # Returns true only if this user is a confessor
  def is_confessor
    self.account_role_ids.include? 3
  end
  
  # Alias username to email for now 
  def username
    self.email
  end
  
  def full_name
    self.first_name + ' ' + self.last_name
  end
  
protected
  # Remove all instances of (,),- or whitespace from phone number
  def normalize_phone_numbers
    self.home_phone = format_phone_number self.home_phone.gsub!(/[\(\)\-\s]/, '')
    self.mobile_phone = format_phone_number self.mobile_phone.gsub!(/[\(\)\-\s]/, '')
    self.work_phone = format_phone_number self.work_phone.gsub!(/[\(\)\-\s]/, '')
  end
  
  def trim_strings
    self.first_name.strip!
    self.last_name.strip!
    self.email.strip!
  end
  
  
private

  # Helper to format a phone number like this: (123)345-2342
  def format_phone_number(num)
    if num && num.length > 0
      return "(" + num[0,3] + ")" + num[3,3] + "-" + num[6,4]
    else
      return ""
    end
  end
end


