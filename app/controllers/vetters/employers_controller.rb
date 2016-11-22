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
    set_employer
  end

  def update
    set_employer
    if @employer.update(employer_params)
      redirect_to vetters_employers_path
    else
      render json: @employer.errors
    end
  end

  private

  def employer_params
    params.require(:employer).permit(:company_name, :name, :email, :password)
  end

  def set_employer
    @employer = Employer.find(params[:id])
  end
end
