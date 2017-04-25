class Review < ApplicationRecord
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :user, uniqueness: true

  belongs_to :user
  belongs_to :meme
  has_many :review_votes

  attr_reader :current_user

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
      false
    else
      true
    end
  end

  def belongs_to_user?(user)
    if self.user == user
      @current_user = true
    else
      @current_user = false
    end
  end
end
