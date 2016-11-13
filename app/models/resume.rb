class Resume < ApplicationRecord
  has_attached_file :file, {
    path: ':job_type/:nationality/:student_id-:resume_id.:extension'
  }

  belongs_to :student

  validates :nationality, presence: true
  validates :job_type, presence: true
  validates_attachment :file, presence: true,
    content_type: {content_type: ["application/pdf"]}

  enum nationality: {
    malaysian: 1,
    foreigner: 2
  }  
  
  enum job_type: {
    full_time: 1,
    internship: 2
  }

  enum status: {
    pending: 0,
    approved: 1,
    rejected: 2
  }

  before_create :generate_reupload_count

  private

  def generate_reupload_count
    self.reuploads = student.resumes.count + 1
  end

  Paperclip.interpolates :s3_sg_url do |attachment, style|
    "#{attachment.s3_protocol}://s3-ap-southeast-1.amazonaws.com/#{attachment.bucket_name}"
  end

  Paperclip.interpolates :job_type do |attachment, style|
    attachment.instance.job_type
  end

  Paperclip.interpolates :nationality do |attachment, style|
    attachment.instance.nationality
  end

  Paperclip.interpolates :student_id do |attachment, style|
    attachment.instance.student.name.parameterize + 
    '-' + 
    (attachment.instance.student.student_id % 1000).to_s
  end

  Paperclip.interpolates :resume_id do |attachment, style|
    attachment.instance.reuploads
  end
end
