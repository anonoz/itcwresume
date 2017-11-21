  class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :resumes
  has_one :resume, ->{ order 'created_at DESC' }, class_name: "Resume"

  validate :email_from_uni

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |student|
      student.email = auth.info.email
      student.name = auth.info.name
      student.student_id = auth.info.email.split('@').first
      domain = auth.info.email.split('@').second
      case domain
      when "student.mmu.edu.my"
        student.university = "MMU"
      when "student.tarc.edu.my"
        student.university = "TARC"
      when "mail.apu.edu.my"
        student.university = "APU"
      when "kdu-online.com"
        student.university = "KDU"
      when "1utar.my"
        student.university = "UTAR"
      when "xmu.edu.my"
        student.university = "XMUMC"
      end
    end
  end

  private

  def email_from_uni
    unless /@student.mmu.edu.my$/.match(email) or /@student.tarc.edu.my$/.match(email) or /@mail.apu.edu.my$/.match(email) or /@kdu-online.com$/.match(email) or /@1utar.my$/.match(email) or /@xmu.edu.my$/.match(email)
      errors.add(:email, "must be gmail address from list of allowed domains!")
    end
  end
end
