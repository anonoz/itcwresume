class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  validate :email_from_mmu

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |student|
      student.email = auth.info.email
      student.student_id = auth.info.email.split('@').first
    end
  end

  private

  def email_from_mmu
    unless /@student.mmu.edu.my$/.match(email)
      errors.add(:email, "must be student.mmu.edu.my gmail address")
    end
  end
end
