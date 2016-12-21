class Employers::ProgressesController < EmployersController
  def update
    Progress.set(
      company_id: current_company.id,
      student_id: params[:student_id],
      progress: params[:progress_id])
    render status: :ok, nothing: true
  end
end
