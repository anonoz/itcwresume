class Students::ResumeController < StudentsController

  def show
    set_student
    set_resume
  end

  def new
    new_resume
  end

  def create
    create_resume
    if @resume.persisted?
      redirect_to resume_path
    else
      redirect_to new_resume_path, flash: {errors: @resume.errors}
    end
  end

  def open
    set_resume
    redirect_to @resume.file.url
  end

  private

  def set_student
    @student = current_student
  end

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
