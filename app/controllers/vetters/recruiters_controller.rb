class Vetters::RecruitersController < VettersController
  def index
    set_company
    @recruiters = @company.employers
  end

  def new
  end

  def create
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_recruiter
    @recruiter = Employer.find(params[:id])
  end
end
