require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should validate_presence_of(:rating) }
  it { should validate_numericality_of(:rating) }
  it { should belong_to(:user) }
  it { should belong_to(:meme) }
  it { should have_many(:review_votes) }
  it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(10) }

  describe '#upvotes' do
    it 'should return the number of upvotes of this review' do
      review = create(:review)
      10.times { create(:review_vote, review: review, upvote: true) }

      expect(review.upvotes).to eq(10)
    end
  end

  describe '#downvotes' do
    it 'should return the number of downvotes of this review' do
      review = create(:review)
      10.times { create(:review_vote, review: review, downvote: true) }

      expect(review.downvotes).to eq(10)
    end
  end

  describe '#vote_count' do
    it 'should return the number of upvotes minus the number of downvotes of this review' do
      review = create(:review)
      10.times { create(:review_vote, review: review, upvote: true) }
      5.times { create(:review_vote, review: review, downvote: true) }

      expect(review.downvotes).to eq(5)

      10.times { create(:review_vote, review: review, downvote: true) }

      expect(review.downvotes).to eq(-5)
    end
  end

  describe '#did_user_vote?' do
    it 'should take a single argument of a user object' do
      review = create(:review)
      10.times { create(:review_vote, review: review, upvote: true) }
      5.times { create(:review_vote, review: review, downvote: true) }

      expect(review.downvotes).to eq(5)

      10.times { create(:review_vote, review: review, downvote: true) }

      expect(review.downvotes).to eq(-5)
    end
  end
end
