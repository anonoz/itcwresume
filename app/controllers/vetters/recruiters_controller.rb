class Vetters::RecruitersController < VettersController
  before_action :set_company

  def index
    @recruiters = @company.employers
  end

  def new
    @recruiter = @company.employers.new
  end

  def create
    @recruiter = @company.employers.new(recruiter_params)
    @password = @recruiter.generate_password
    @recruiter.save!
    RecruiterMailer.account_created_email(@recruiter, password: @password).deliver_now
    redirect_to action: :index
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_recruiter
    @recruiter = Employer.find(params[:id])
  end

  def recruiter_params
    params.require(:recruiter).permit(:name, :email)
  end
end
