class Resume < ApplicationRecord
  has_attached_file :file,
    path: ':job_type/:nationality/:student_id-:resume_id.:extension',
    preserve_files: true

  belongs_to :student

  validates :nationality, presence: true
  validates :job_type, presence: true
  validates_attachment :file, presence: true,
    content_type: {content_type: ["application/pdf"]},
    size: { in: 0..1.megabytes }
  validate :resume_has_only_one_page

  enum nationality: {
    malaysian: 1,
    foreigner: 2
  }
  
  enum job_type: {
    full_time: 1,
    internship: 2,
    freelance: 3
  }

  enum status: {
    pending: 0,
    approved: 1,
    rejected: 2
  }

  before_create :generate_reupload_count
  after_create :notify_slackbot_create
  before_save :notify_slackbot_status_changed, if: :status_changed?

  scope :latest_submissions, ->{
    where(id: select("DISTINCT ON(student_id) id")
      .order("student_id, created_at DESC"))
  }

  # I didn't expect there are so little full-timer submissions, I need to 
  # buff them a bit to get noticed.
  #
  # Also need to nerf freelancers coz the 3 submissions too OP
  #
  scope :for_employers, ->{
    latest_submissions.approved.includes(:student).order("job_type ASC")
  }

  private

  def generate_reupload_count
    self.reuploads = student.resumes.count + 1
  end

  def notify_slackbot_create
    SlackbotNotifier.new.notify_resume_upload(self)
  end

  def notify_slackbot_status_changed
    case status
    when "approved"
      SlackbotNotifier.new.notify_resume_approved(self)
    when "rejected"
      SlackbotNotifier.new.notify_resume_rejected(self)
    end
  end

  def resume_has_only_one_page
    return unless file.queued_for_write.any?
    unless PDF::Reader.new(file.queued_for_write[:original].path).page_count == 1
      errors.add("file_one_page", message: "must be 1 page only")
    end
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
