class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: [:full_access, :restricted_access]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def role_br
    if self.role == 'full_access'
        'Acesso Completo'
    else
        'Acesso Restrito'
    end
  end

end
