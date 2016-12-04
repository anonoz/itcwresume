class ResumeMailer < ApplicationMailer
  def rejection_email(resume)
    @resume = resume
    @rejection_reason = @resume.rejection_reason
    mail(to: @resume.student.email, subject: 'Your Resume is Rejected')
  end

  def approval_email(resume)
    @resume = resume
    mail(to: @resume.student.email, subject: '[ITCW] Your Resume Is Approved')
  end
end
