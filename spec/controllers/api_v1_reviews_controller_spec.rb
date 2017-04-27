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
        expect(json_parsed_response.first["id"]).to eq(review.id)
      end
      it "as a signed in user" do
        meme = create(:meme)
        review = create(:review, meme: meme)
        user = create(:user)
        sign_in user

        get :index, meme_id: meme.id

        expect(response.status).to eq 200
        expect(json_parsed_response.first["id"]).to eq(review.id)
      end
    end
    describe "it returns a vote_count" do
      it "returns 0 when there are 0 votes" do
        meme = create(:meme)
        review = create(:review, meme: meme)

        get :index, meme_id: meme.id

        expect(json_parsed_response.first["vote_count"]).to eq(0)
      end
      it "returns the difference between upvotes and downvotes" do
        meme = create(:meme)
        review = create(:review, meme: meme)
        10.times { create(:review_vote, review: review, upvote: true) }
        7.times { create(:review_vote, review: review, downvote: true) }

        get :index, meme_id: meme.id

        expect(json_parsed_response.first["vote_count"]).to eq(3)
      end
    end
    describe 'it returns a user hash' do
      it 'with the username of the review author' do
        user = create(:user)
        meme = create(:meme)
        review = create(:review, meme: meme, user: user)

        get :index, meme_id: meme.id

        expect(json_parsed_response.first["user"]["username"]).to eq(user.username)
      end
    end
    describe 'it returns a boolean of whether it belongs_to_tested_user' do
      it 'returns true when current user is the author of the review' do
        user = create(:user)
        meme = create(:meme)
        review = create(:review, meme: meme, user: user)
        sign_in user

        get :index, meme_id: meme.id

        expect(json_parsed_response.first["belongs_to_tested_user"]).to eq(true)
      end
      it 'returns false when current user is NOT the author of the review' do
        user = create(:user)
        meme = create(:meme)
        review = create(:review, meme: meme)
        sign_in user

        get :index, meme_id: meme.id

        expect(json_parsed_response.first["belongs_to_tested_user"]).to eq(false)
      end
      it 'returns false when no user signed in' do
        meme = create(:meme)
        review = create(:review, meme: meme)

        get :index, meme_id: meme.id

        expect(json_parsed_response.first["belongs_to_tested_user"]).to eq(false)
      end
    end
  end

  describe "PUT/PATCH #update" do
    let(:upvote_params) { review_vote: { upvote: true } }
    let(:downvote_params) { review_vote: { upvote: false } }
    let(:incorrect_params) { review_vote: { upvote: "true" } }

    it "it returns the nomination as JSON" do
      sign_in(user)
      post :create, params: { post: correct_post_params }

      expect(response.status).to eq 200
      expect(json_parsed_response.keys).to eq ["id", "summary", "url", "user_id", "created_at", "updated_at"]
    end

    it "successfully creates a post" do
      sign_in(user)
      expect { post :create, params: { post: correct_post_params } }.to change{ Post.count }.by 1
    end

    it "returns an error when the payload is incorrect" do
      sign_in(user)
      post :create, params: { post: incorrect_post_params }

      expect(response.status).to eq 422
      expect(json_parsed_response.keys).to eq ["errors"]
      expect(json_parsed_response["errors"]).to eq({"summary" => ["can't be blank"], "url" => ["must be a valid URL"]})
    end
  end
end
