class ReviewMailer < ActionMailer::Base

  def review_email(user,review)
  	@user = user
  	@review = review
	mail(to: "support@groupmates.uk", subject: 'User Feedback', from: @user.email,  reply_to: @user.email)
  end
end