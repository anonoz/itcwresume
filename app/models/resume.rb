class Resume < ApplicationRecord
  has_attached_file :file

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
end
