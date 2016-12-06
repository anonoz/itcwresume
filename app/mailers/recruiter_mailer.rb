class RecruiterMailer < ApplicationMailer
  def account_created_email(recruiter, password:)
    @recruiter_name = recruiter.name
    @recruiter_email = recruiter.email
    @password = password

    mail(to: "#{@recruiter_name} <#{@recruiter_email}>", subject: "You can now access IT Career Week Resumes")
  end
end
