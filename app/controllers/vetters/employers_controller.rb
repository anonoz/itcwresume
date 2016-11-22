class Vetters::EmployersController < VettersController
  def index
    @employers = Employer.order("company_name ASC").all
  end

  def new
    @employer = Employer.new
  end

  def create
    @employer = Employer.new(employer_params)
    @employer.save!
    redirect_to vetters_employers_path
  end

  def edit
  end

  private

  def employer_params
    params.require(:employer).permit(:company_name, :email, :password)
  end
end
