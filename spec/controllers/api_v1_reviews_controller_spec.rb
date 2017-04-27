require "rails_helper"

RSpec.describe Api::V1::ReviewsController, type: :controller do
  let(:json_parsed_response)  { JSON.parse(response.body) }

  describe "GET #index" do
    describe "it returns data" do
      it "without signing in" do
        meme = create(:meme)
        review = create(:review, meme: meme)

        get :index, meme_id: meme.id

        expect(response.status).to eq 200
        expect(json_parsed_response["reviews"].first.keys).to eq ["id", "rating", "body", "meme_id", "user_id", "created_at", "updated_at", "vote_count", "belongs_to_tested_user", "user"]
        expect(json_parsed_response["reviews"].first["id"]).to eq(review.id)
        expect(json_parsed_response["current_user"]["admin"]).to be false
      end
      it "as a signed in user" do
        meme = create(:meme)
        review = create(:review, meme: meme)
        user = create(:user)
        sign_in user

        get :index, meme_id: meme.id

        expect(response.status).to eq 200
        expect(json_parsed_response["reviews"].first.keys).to eq ["id", "rating", "body", "meme_id", "user_id", "created_at", "updated_at", "vote_count", "belongs_to_tested_user", "user"]
        expect(json_parsed_response["reviews"].first["id"]).to eq(review.id)
        expect(json_parsed_response["current_user"]["admin"]).to be false
      end
    end
    describe "it returns the current_user" do
      it "returns true if the current_user is an admin" do
        meme = create(:meme)
        create(:review, meme: meme)
        user = create(:user, admin: true)
        sign_in user

        get :index, meme_id: meme.id

        expect(json_parsed_response["current_user"]["admin"]).to be true
      end
      it "returns false if the current_user is NOT an admin" do
        meme = create(:meme)
        create(:review, meme: meme)
        user = create(:user)
        sign_in user

        get :index, meme_id: meme.id

        expect(json_parsed_response["current_user"]["admin"]).to be false
      end
      it "returns false if no user is signed in" do
        meme = create(:meme)
        create(:review, meme: meme)
        create(:user, admin: true)

        get :index, meme_id: meme.id

        expect(json_parsed_response["current_user"]["admin"]).to be false
      end
    end
    describe "it returns a vote_count" do
      it "returns 0 when there are 0 votes" do
        meme = create(:meme)
        create(:review, meme: meme)

        get :index, meme_id: meme.id

        expect(json_parsed_response["reviews"].first["vote_count"]).to eq(0)
      end
      it "returns the difference between upvotes and downvotes" do
        meme = create(:meme)
        review = create(:review, meme: meme)
        10.times { create(:review_vote, review: review, upvote: true) }
        7.times { create(:review_vote, review: review, downvote: true) }

        get :index, meme_id: meme.id

        expect(json_parsed_response["reviews"].first["vote_count"]).to eq(3)
      end
    end
    describe 'it returns a user hash' do
      it 'with the username of the review author' do
        user = create(:user)
        meme = create(:meme)
        create(:review, meme: meme, user: user)

        get :index, meme_id: meme.id

        expect(json_parsed_response["reviews"].first["user"]["username"]).to eq(user.username)
      end
    end
    describe 'it returns a boolean of whether it belongs_to_tested_user' do
      it 'returns true when current user is the author of the review' do
        user = create(:user)
        meme = create(:meme)
        review = create(:review, meme: meme, user: user)
        sign_in user

        get :index, meme_id: meme.id

        expect(json_parsed_response["reviews"].first["belongs_to_tested_user"]).to eq(true)
      end
      it 'returns false when current user is NOT the author of the review' do
        user = create(:user)
        meme = create(:meme)
        create(:review, meme: meme)
        sign_in user

        get :index, meme_id: meme.id

        expect(json_parsed_response["reviews"].first["belongs_to_tested_user"]).to eq(false)
      end
      it 'returns false when no user signed in' do
        meme = create(:meme)
        create(:review, meme: meme)

        get :index, meme_id: meme.id

        expect(json_parsed_response["reviews"].first["belongs_to_tested_user"]).to eq(false)
      end
    end
  end

  describe "PUT/PATCH #update" do
    it "returns the meme reviews as JSON" do
      meme = create(:meme)
      review = create(:review, meme: meme)
      user = create(:user)
      sign_in user

      put :update, params: { meme_id: meme.id, id: review.id, review_vote: { upvote: true } }, as: :json

      expect(response.status).to eq 200
      expect(json_parsed_response["reviews"].first.keys).to eq ["id", "rating", "body", "meme_id", "user_id", "created_at", "updated_at", "vote_count", "belongs_to_tested_user", "user"]
    end
    it "requires user to be signed in" do
      meme = create(:meme)
      review = create(:review, meme: meme)

      put :update, params: { meme_id: meme.id, id: review.id, review_vote: { upvote: true } }, as: :json

      expect(ReviewVote.count).to eq 0
    end
    it "successfully creates a review vote if current user has not voted" do
      meme = create(:meme)
      review = create(:review, meme: meme)
      user = create(:user)
      sign_in user

      expect { put :update, params: { meme_id: meme.id, id: review.id, review_vote: { upvote: true } }, as: :json }.to change { ReviewVote.count }.by 1
    end
    it "successfully updates a review vote if current user has already voted" do
      meme = create(:meme)
      review = create(:review, meme: meme)
      user = create(:user)
      vote = create(:review_vote, review: review, user: user)
      sign_in user

      expect(ReviewVote.count).to eq 1
      expect(ReviewVote.find(vote.id).upvote).to be false

      put :update, params: { meme_id: meme.id, id: review.id, review_vote: { upvote: true } }, as: :json

      expect(ReviewVote.count).to eq 1
      expect(ReviewVote.find(vote.id).upvote).to be true
    end
    # it "returns an error when the payload is incorrect" do
    #   sign_in(user)
    #   post :create, params: { post: incorrect_post_params }
    #
    #   expect(response.status).to eq 422
    #   expect(json_parsed_response.keys).to eq ["errors"]
    #   expect(json_parsed_response["errors"]).to eq({"summary" => ["can't be blank"], "url" => ["must be a valid URL"]})
    # end
  end

  describe "DELETE #destroy" do
    it "returns the meme reviews as JSON" do
      meme = create(:meme)
      create(:review, meme: meme)
      review = create(:review, meme: meme)
      user = create(:user)
      sign_in user

      delete :destroy, params: { meme_id: meme.id, id: review.id }, as: :json

      expect(response.status).to eq 200
      expect(json_parsed_response["reviews"].first.keys).to eq ["id", "rating", "body", "meme_id", "user_id", "created_at", "updated_at", "vote_count", "belongs_to_tested_user", "user"]
    end
    it "requires user to be signed in" do
      meme = create(:meme)
      review = create(:review, meme: meme)

      expect(Review.count).to eq 1

      delete :destroy, params: { meme_id: meme.id, id: review.id }, as: :json

      expect(Review.count).to eq 1
    end
    it "successfully deletes a review if review author is signed in" do
      meme = create(:meme)
      user = create(:user)
      sign_in user
      review = create(:review, meme: meme, user: user)

      expect { delete :destroy, params: { meme_id: meme.id, id: review.id }, as: :json }.to change { Review.count }.by -1
    end
  end
end
