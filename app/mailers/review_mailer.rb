class ReviewMailer < ApplicationMailer
  def new_review(review)
    @review = review

    mail(
    to: review.meme.contributor.email,
    subject: "New Review for #{review.meme.name}"
    )
  end
end
