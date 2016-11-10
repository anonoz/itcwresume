class ResumeController < ApplicationController
  before_action :authenticate_student!
  
  def show
    set_resume
  end

  def new
    new_resume
  end

  def create
    create_resume
    render json: @resume
  end

  private

  def set_resume
    @resume = current_student.resume
  end

  def new_resume
    @resume = current_student.resumes.new
  end

  def create_resume
    @resume = current_student.resumes.create(resume_params)
  end

  def resume_params
    params.require(:resume).permit(:file, :nationality, :job_type)
  end
end
