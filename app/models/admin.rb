class Admin < ActiveRecord::Base
  #Costants
  ROLES = {:full_access => 0, :restricted_access => 1 }

  #enums
  enum role: ROLES

 # scopes
  scope :with_full_access, -> { where(role:ROLES[:full_access]).order(:name) }
  scope :with_restricted_access, -> { where(role:ROLES[:restricted_access]).order(:name) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
