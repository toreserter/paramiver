class MailsenderController < ApplicationController
  def create
    @email = params[:email]
    @user = params[:user]
    @debt = params[:debt]
    UserMailer.debt_reminder(@email, @debt, @user).deliver
  end
end
