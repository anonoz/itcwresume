class Vetters::CompaniesController < VettersController
  def index
    @companies = Company.all.order("name DESC")
    @recruiters_count = Employer.all.group(:company_id).count
  end

  def new
    @company = Company.new
  end

  def create
    Company.create! company_params
    redirect_to vetters_companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end
end
