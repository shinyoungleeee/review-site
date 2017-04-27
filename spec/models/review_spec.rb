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

      expect(review.vote_count).to eq(5)

      10.times { create(:review_vote, review: review, downvote: true) }

      expect(review.vote_count).to eq(-5)
    end
  end

  describe '#did_user_vote?(user)' do
    it 'should return true if the user has already voted' do
      user = create(:user)
      review = create(:review)
      create(:review_vote, review: review, user: user)

      expect(review.did_user_vote?(user)).to be true
    end

    it 'should return false if the user has NOT voted' do
      user = create(:user)
      review = create(:review)
      create(:review_vote, review: review)

      expect(review.did_user_vote?(user)).to be false
    end
  end

  describe '#belongs_to_tested_user' do
    it 'should return true if this review belongs to the user' do
      user = create(:user)
      review = create(:review, user: user)
      # #check_belongs_to_user(tested_user) must be run first!
      review.check_belongs_to_user(user)

      expect(review.belongs_to_tested_user).to be true
    end

    it '#current_user should return false if this review does NOT belong to the user' do
      user = create(:user)
      review = create(:review)
      review.check_belongs_to_user(user)

      expect(review.belongs_to_tested_user).to be false
    end
  end
end
