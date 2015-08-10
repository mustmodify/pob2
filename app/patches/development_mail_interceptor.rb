class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = ['jw@mustmodify.com']
    message.cc = []
    message.bcc = []
  end
end

