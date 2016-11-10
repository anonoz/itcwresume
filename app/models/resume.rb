class Resume < ApplicationRecord
  has_attached_file :file, {
    url: '/:job_type/:nationality/:student_id-:resume_id.:extension'
  }

  belongs_to :student

  validates :nationality, presence: true
  validates :job_type, presence: true
  validates_attachment :file, presence: true,
    content_type: {content_type: ["application/pdf", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]}
  
  enum nationality: {
    malaysian: 1,
    foreigner: 2
  }  
  
  enum job_type: {
    full_time: 1,
    internship: 2
  }

  private

  Paperclip.interpolates :job_type do |attachment, style|
    attachment.instance.job_type
  end

  Paperclip.interpolates :nationality do |attachment, style|
    attachment.instance.nationality
  end

  Paperclip.interpolates :student_id do |attachment, style|
    attachment.instance.student.name.parameterize
  end

  Paperclip.interpolates :resume_id do |attachment, style|
    attachment.instance.student.resumes.count + 1
  end
end
