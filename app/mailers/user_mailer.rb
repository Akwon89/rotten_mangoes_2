class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000/sessions/new"
    mail(to: @user.email, subject: 'Welcome to Rotten Mangoes!')
  end

  def delete_email(user)
    @user = user
    @url = "http://localhost:3000/users/new"
    mail(to: @user.email, subject: "Your account has been deleted")
  end

end
