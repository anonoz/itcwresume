class Vetters::ResumesController < VettersController
  def index
    @pending_resumes = Resume.pending.includes(:student)
    @approved_resumes = Resume.approved.order("created_at DESC").
      distinct(:student_id).includes(:student)
    @rejected_resumes = Resume.rejected.order("updated_at DESC").
      distinct(:student_id).includes(:student)
  end

  def show
  end

  def edit
    set_resume
  end

  def approve
    set_resume
    @resume.approved!
    redirect_to action: :index
  end

  def reject
    set_resume
    @resume.update(reject_resume_params.merge(status: :rejected))
    redirect_to action: :index
    ResumeMailer.rejection_email(@resume).deliver_now
  end

  private

  def set_resume
    @resume = Resume.find(params[:id])
  end

  def reject_resume_params
    params.require(:resume).permit(:rejection_reason)
  end
end
