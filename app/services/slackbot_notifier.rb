class SlackbotNotifier
  include HTTParty
  base_uri 'https://itscyber.slack.com'

  def initialize
    @options = {
      query: {
        token: ENV['SLACKBOT_TOKEN'],
        channel: "##{ENV['SLACKBOT_CHANNEL']}"
      }
    }
  end

  def notify_resume_upload(resume)
    send_message("#{resume.student.name} has uploaded a new resume "\
      "(rev #{resume.reuploads}). #{Resume.pending.count} pending. ")
  end

  def notify_resume_approved(resume)
    send_message("#{resume.student.name}'s resume is approved. "\
      "#{Resume.latest_submissions.pending.count - 1} left to go. ")
  end

  def notify_resume_rejected(resume)
    send_message("#{resume.student.name}'s resume is rejected. "\
      "#{Resume.latest_submissions.pending.count - 1} left to go. ")
  end

  private

  def send_message(message)
    self.class.post("/services/hooks/slackbot", @options.merge(body: message))
  end
end
