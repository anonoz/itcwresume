class EmployersController < ApplicationController
  layout 'layouts/employer'

  before_action :authenticate_employer!

  def contact_us
  end

  private

  def current_company
    current_employer.company
  end
end
