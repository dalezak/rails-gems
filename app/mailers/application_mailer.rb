class ApplicationMailer < ActionMailer::Base

  default content_type: "text/html"
  default from: ENV['APP_EMAIL']
  default template_path: -> { "mailers" }
  default template_name: ->(mailer) { mailer.class.name.underscore }
  helper :application
  layout 'mailer'

  def prepare(*args)
    # children class should override this method
  end

end
