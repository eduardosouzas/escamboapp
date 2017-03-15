class Member < ActiveRecord::Base
  # gem RatyRate
  ratyrate_rater
    # Associations
  has_many :ads
  has_one :profile_member

  validate :nested_attributes

  accepts_nested_attributes_for :profile_member
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def nested_attributes
    if nested_attributes_blank?
        errors.add(:base, "É necessário preencher os campos Primeiro e segundo nomes")
    end
  end

  def nested_attributes_blank?
    self.profile_member.first_name.blank? && self.profile_member.second_name.blank?
  end

end
