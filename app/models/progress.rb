class Progress < ApplicationRecord
  belongs_to :student
  belongs_to :company

  validates :company_id, presence: true
  validates :student_id, presence: true
  validates :progress, presence: true

  enum progress: {
    inbox: 0,
    starred: 1,
    completed: 2,
    ignored: 3
  }

  scope :inbox, ->{where(progess: :inbox)}

  def self.set(company_id:, student_id:, progress:)
    if progress == "inbox"
      where(company_id: company_id, student_id: student_id).destroy_all
    else
      where(company_id: company_id, student_id: student_id).
        first_or_create.update(progress: progress)
    end 
  end
end
