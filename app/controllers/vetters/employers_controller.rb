class Vetters::EmployersController < VettersController
  def index
    @employers = Employer.order("company_name ASC").all
  end

  def edit
  end

  private

end
