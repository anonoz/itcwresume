class Employers::ResumesController < EmployersController
  layout 'layouts/employer'
  
  def index

  end

  def full_time
    @resumes = Resume.approved.full_time.includes(:student)
    render_scoped_index(resumes: @resumes, resumes_type: "Full-time")
  end

  def internship
    @resumes = Resume.approved.internship.includes(:student)
    render_scoped_index(resumes: @resumes, resumes_type: "Internship")
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
    @resumes_json = @resumes.collect {|resume| Employers::ResumesSerializer.new(resume)}.to_json
    render :index_scoped
  end
end
