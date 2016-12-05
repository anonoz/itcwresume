class StudentsController < ApplicationController
  layout 'layouts/student'
  before_action :authenticate_student!
end
