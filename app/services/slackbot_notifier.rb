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
    body = {
      body: "#{resume.student.name} has uploaded a new resume (rev #{resume.reuploads}). https://itcwresume.herokuapp.com/vetters/resumes",
    }
    self.class.post("/services/hooks/slackbot", @options.merge(body))
  end
end
