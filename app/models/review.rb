class Review < ApplicationRecord
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :user, uniqueness: true

  belongs_to :user
  belongs_to :meme
  has_many :review_votes

  attr_reader :user_voted, :user_upvote, :user_downvote

  def upvotes
    self.review_votes.where(upvote: true).length
  end

  def downvotes
    self.review_votes.where(downvote: true).length
  end

  def vote_count
    upvotes - downvotes
  end

  def did_user_vote?(user)
    if review_votes.where(user: user).empty?
      @user_voted = false
      @user_upvote = false
      @user_downvote = false
    else
      @user_voted = true
      @user_upvote = review_votes.where(user: user).first.upvote
      @user_downvote = review_votes.where(user: user).first.downvote
    end
  end
end
