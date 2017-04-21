class ReviewVote < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates :user, uniqueness: { scope: :review_id }
end
