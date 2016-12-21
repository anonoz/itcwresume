class ResumeMailer < ApplicationMailer
  def rejection_email(resume)
    @resume = resume
    @student = resume.student
    @rejection_reason = @resume.rejection_reason
    @to_address = @student.email_address.present? ? @student.email_address : @student.email
    mail(to: @to_address, subject: 'Your Resume is Rejected')
  end

  def approval_email(resume)
    @resume = resume
    mail(to: @resume.student.email, subject: '[ITCW] Your Resume Is Approved')
  end
end
