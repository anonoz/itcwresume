class Vetters::ResumesController < VettersController
  def index
    @pending_resumes  = Resume.pending.order("updated_at DESC").includes(:student)
    @approved_resumes = Resume.approved.order("updated_at DESC").includes(:student)
    @rejected_resumes = Resume.rejected.order("updated_at DESC").includes(:student)
  end

  def show
  end

  def edit
    set_resume
    @rejections_history = Resume.where(student_id: @resume.student_id, status: :rejected)
      .order("created_at DESC")
      .pluck(:rejection_reason)
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
