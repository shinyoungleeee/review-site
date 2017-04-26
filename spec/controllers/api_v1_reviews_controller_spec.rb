# require "rails_helper"
#
# RSpec.describe Api::V1::ReviewsController, type: :controller do
#   let(:json_parsed_response)  { JSON.parse(response.body) }
#
#   describe "POST #create" do
#     let(:user) { create :user }
#
#     let(:correct_post_params) { { summary: "#CARMILLAMOVIE", url: "http://carmillamovie.vhx.tv" } }
#     let(:incorrect_post_params) { { summary: "", url: "foobar" } }
#
#     it "it returns the nomination as JSON" do
#       sign_in(user)
#       post :create, params: { post: correct_post_params }
#
#       expect(response.status).to eq 200
#       expect(json_parsed_response.keys).to eq ["id", "summary", "url", "user_id", "created_at", "updated_at"]
#     end
#
#     it "successfully creates a post" do
#       sign_in(user)
#       expect { post :create, params: { post: correct_post_params } }.to change{ Post.count }.by 1
#     end
#
#     it "returns an error when the payload is incorrect" do
#       sign_in(user)
#       post :create, params: { post: incorrect_post_params }
#
#       expect(response.status).to eq 422
#       expect(json_parsed_response.keys).to eq ["errors"]
#       expect(json_parsed_response["errors"]).to eq({"summary" => ["can't be blank"], "url" => ["must be a valid URL"]})
#     end
#   end
#
#   describe "GET #index" do
#     let(:user) { create :user }
#     let!(:users_post) { create :post, user: user }
#     let!(:someone_elses_post) { create :post }
#
#     describe "it returns data" do
#       it "as a signed in user" do
#         sign_in(user)
#         get :index
#
#         expect(response.status).to eq 200
#
#         expect(json_parsed_response.first["id"]).to eq(users_post.id)
#       end
#     end
#   end
#
# end
