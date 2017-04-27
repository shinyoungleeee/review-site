class Review < ApplicationRecord
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :user, uniqueness: { scope: :rating }

  belongs_to :user
  belongs_to :meme
  has_many :review_votes

  def upvotes
    review_votes.where(upvote: true).length
  end

  def downvotes
    review_votes.where(downvote: true).length
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

  def check_belongs_to_user(tested_user)
    if user == tested_user
      @tested_user = true
    else
      @tested_user = false
    end
  end

  def belongs_to_tested_user
    if @tested_user
      true
    else
      false
    end
  end
end
