class ResumeMailer < ApplicationMailer
  def rejection_email(resume)
    @resume = resume
    set_student
    set_to_address
    @rejection_reason = @resume.rejection_reason
    mail(to: @to_address, subject: '[ITCW17] Tips to improve your resume')
  end

  def approval_email(resume)
    @resume = resume
    set_student
    set_to_address
    mail(to: @resume.student.email, subject: '[ITCW17] Your Resume Is Approved! Are you ready?')
  end

  private

  def set_student
    @student = @resume.student
  end

  def set_to_address
    @to_address = @student.email_address.present? ? @student.email_address : @student.email
  end
end
