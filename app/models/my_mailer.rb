class MyMailer < ActionMailer::Base
    
  def mail(recipient, group, hash)
    from "alwendy@gmail.com"
    recipients recipient
    subject  "Lunch voting invite from #{group} group"
    body(:recipient => recipient, :group => group, :hash => hash)
  end
  
end
