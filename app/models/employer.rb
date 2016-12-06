##
# New term for this model: RECRUITER

class Employer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable

  belongs_to :company

  def generate_password
    self.password = SecureRandom.hex(4)
  end
end
