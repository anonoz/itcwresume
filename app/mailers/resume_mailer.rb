class ResumeMailer < ApplicationMailer
  def rejection_email(resume)
    @resume = resume
    set_student
    set_to_address
    @rejection_reason = @resume.rejection_reason
    mail(to: @to_address, subject: '[TCD] Your Resume Is Rejected')
  end

  def approval_email(resume)
    @resume = resume
    set_student
    set_to_address
    mail(to: @resume.student.email, subject: '[TCD] Your Resume Is Approved! Are you ready?')
  end

  private

  def set_student
    @student = @resume.student
  end

  def set_to_address
    @to_address = @student.email_address.present? ? @student.email_address : @student.email
  end
end
