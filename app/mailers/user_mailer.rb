class UserMailer < ActionMailer::Base
  default from: "noreplyparamiver@gmail.com"

  def debt_reminder(email,debt,user)
      @email = email
      @debt = debt
      @user = user
    mail(:to => @email.downcase, :subject => "You have debt!")
  end
end
