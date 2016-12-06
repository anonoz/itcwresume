class Employers::ResumesSerializer < ActiveModel::Serializer
  attributes :student_name, :student_id, :nationality, :file_url, :student_phone, :student_email

  def student_name
    object.student.name || ""
  end

  def student_id
    object.student.student_id
  end

  def student_nationality
    object.nationality.humanize
  end

  def file_url
    object.file.url
  end

  def student_phone
    object.student.phone_number ? "+#{object.student.phone_number}" : nil
  end

  def student_email
    object.student.email_address
  end
end
