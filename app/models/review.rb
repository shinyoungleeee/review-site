class Review < ApplicationRecord
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :votes, presence: true
  validates :votes, numericality: true

  belongs_to :user
  belongs_to :meme
end
