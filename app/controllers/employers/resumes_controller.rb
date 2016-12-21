class Employers::ResumesController < EmployersController
  layout 'layouts/employer'
  
  def index
    redirect_to action: :inbox
  end

  def inbox
    @new_students = Student.where.not(id: Progress.where(company: current_company).pluck(:student_id))
    @new_resumes = Resume.for_employers.where(student_id: @new_students)
    render_scoped_index(resumes: @new_resumes, resumes_type: "New Resumes")
  end

  def starred
    @starred_students = Student.where(id: Progress.where(progress: :starred, company: current_company).pluck(:student_id))
    @starred_resumes = Resume.for_employers.where(student_id: @starred_students)
    render_scoped_index(resumes: @starred_resumes, resumes_type: "Starred Resumes")
  end

  def completed
    @completed_students = Student.where(id: Progress.where(progress: :completed, company: current_company).pluck(:student_id))
    @completed_resumes = Resume.for_employers.where(student_id: @completed_students)
    render_scoped_index(resumes: @completed_resumes, resumes_type: "Completed Resumes")
  end

  def ignored
    @ignored_students = Student.where(id: Progress.where(progress: :ignored, company: current_company).pluck(:student_id))
    @ignored_resumes = Resume.for_employers.where(student_id: @ignored_students)
    render_scoped_index(resumes: @ignored_resumes, resumes_type: "Ignored Resumes")
  end

  def search
    begin
      @student = Student.find_by!(student_id: params[:student_id])
      @resume = @student.resume
      redirect_to @resume.file.url
    rescue ActiveRecord::RecordNotFound => e
      if e.model == "Student"
        @title = "Student Not Found"
        @student_id = params[:student_id]
        render :student_not_found, status: 404
      end
    rescue NoMethodError => e
      if e.name == :file
        @title = "Resume Not Uploaded"
        render :resume_not_found, status: 404
      end
    end
  end

  private

  def render_scoped_index(resumes:, resumes_type:)
    @title = resumes_type
    @resumes_json = resumes.collect {|resume| Employers::ResumesSerializer.new(resume)}.to_json
    render :index_scoped
  end

  def status_update_params

  end
end
