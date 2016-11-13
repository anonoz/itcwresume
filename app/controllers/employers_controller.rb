class EmployersController < ApplicationController
  layout 'layouts/employer'

  before_action :authenticate_employer!

  def contact_us
  end
end
