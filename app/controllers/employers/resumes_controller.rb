class Employers::ResumesController < EmployersController
  layout 'layouts/employer'
  
  def index
    redirect_to action: :inbox
  end

  def show
    if params[:type] == "new"
      @student_ids = Student.where.not(id: Progress.where(company: current_company).pluck(:student_id))
    else
      set_student_ids_by_progress(params[:type])
    end
    set_resumes
    @resume = @resumes.find_by(student_id: params[:id])
    @next_resume_id = @resumes.map(&:student_id).index((params[:id].to_i)+1)
    @prev_resume_id = @resumes.map(&:student_id).index((params[:id].to_i)-1)
  end

  def inbox
    @student_ids = Student.where.not(id: Progress.where(company: current_company).pluck(:student_id))
    set_resumes
    render_scoped_index(resumes: @resumes, resumes_type: "New Resumes")
  end

  def starred
    set_student_ids_by_progress(:starred)
    set_resumes
    render_scoped_index(resumes: @resumes, resumes_type: "Starred Resumes")
  end

  def completed
    set_student_ids_by_progress(:completed)
    set_resumes
    render_scoped_index(resumes: @resumes, resumes_type: "Completed Resumes")
  end

  def ignored
    set_student_ids_by_progress(:ignored)
    set_resumes
    render_scoped_index(resumes: @resumes, resumes_type: "Ignored Resumes")
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

  def set_student_ids_by_progress(progress_id)
    @student_ids = Student.
      where(id: Progress.where(progress: progress_id, company: current_company).
        pluck(:student_id))
  end

  def set_resumes
    @resumes = Resume.for_employers.where(student_id: @student_ids)
  end
end
