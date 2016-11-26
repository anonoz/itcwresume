class Employers::ResumesSerializer < ActiveModel::Serializer
  attributes :student_name, :student_id, :nationality, :file_url

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
end
