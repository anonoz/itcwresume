class EmployersController < ApplicationController
  layout 'layouts/employer'

  before_action :authenticate_employer!, :set_navbar_resume_counts, :set_current_company

  def contact_us
  end

  private

  def set_navbar_resume_counts
    inbox_count = Resume.for_employers.select("distinct student_id").count - Progress.where(company_id: current_company.id).select("distinct student_id").count
    other_counts = Progress.where(company_id: current_company.id).group(:progress).select("distinct student_id").count
    @navbar_resume_counts = other_counts.merge(0 => inbox_count)
  end

  def current_company
    current_employer.company
  end

  def set_current_company
    @current_company = current_company
  end
end
