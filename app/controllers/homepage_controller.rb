class HomepageController < ApplicationController
  layout 'layouts/homepage'
  
  def index
    @job_types_count = Resume.latest_submissions.group(:job_type).count
  end
end
