class Students::ContactInfoController < StudentsController
  def update
    current_student.update!(contact_info_params)
    redirect_to resume_path, flash: {contact_details_updated: true}
  end

  private

  def contact_info_params
    params.require(:student).permit(:phone_number, :email_address)
  end
end
