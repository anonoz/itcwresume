class Vetters::ResumesController < VettersController
  def index
    @latest_resumes = Resume.distinct(:student_id).
      order("created_at DESC").all.includes(:student).load
    @latest_resume_ids = @latest_resumes.pluck(:id)
    
    @pending_resumes  = Resume.where(id: @latest_resume_ids).pending
    @approved_resumes = Resume.where(id: @latest_resume_ids).approved
    @rejected_resumes = Resume.where(id: @latest_resume_ids).rejected
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
