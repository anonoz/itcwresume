class Employers::ResumesController < EmployersController
  layout 'layouts/employer'
  
  def index
    
  end

  def full_time
    @resumes = Resume.full_time
    render :index
  end

  def internship
    @resumes = Resume.internship
    render :index
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
        render :resume_not_found, status: 404
      end
    end
  end
end
