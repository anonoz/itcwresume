class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    case resource
    when Employer then resumes_path
    when Student then resume_path
    when Vetter then vetters_resumes_path
    else raise 'Unknown Resource'
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def current_user
    current_student || current_employer || current_vetter
  end
end
