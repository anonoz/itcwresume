  class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :resumes
  has_one :resume, ->{ order 'created_at DESC' }, class_name: "Resume"

  validate :email_from_mmu

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |student|
      student.email = auth.info.email
      student.name = auth.info.name
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
