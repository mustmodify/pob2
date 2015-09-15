class PostOffice < ActionMailer::Base
  default from: 'MAKO Unlimited <operations@makounlimited.com>'

  def certs( recipient, employee, list )
    @list= list
    @employee = employee

    list.each_with_index do |cert, index|
      attachments[ "#{index}_#{cert.image_file_name}" ] = File.read(cert.image.path)
    end

    mail(to: [recipient], subject: "Certs for #{employee.name}")
  end
end
