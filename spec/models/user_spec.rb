require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_length_of(:username).is_at_least(4).is_at_most(16) }
  it { should allow_values('username', 'username1', 'user_name', 'user.name', '_username').for(:username) }
  it { should_not allow_values('user name', '.username', 'username.', 'user..name', 'user-name').for(:username) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_values('email@email.com', 'email123@email.com', 'email.email@email.com').for(:email) }
  it { should_not allow_values('emailemail.com', 'email@emailcom', 'email@email..com', "'em..ail@email.com'").for(:email) }

  it { should validate_presence_of(:encrypted_password) }
  it { should validate_length_of(:encrypted_password).is_at_least(6) }

  it { should have_many(:reviews) }
  it { should have_many(:contributed_memes) }
  it { should have_many(:review_votes) }

  let(:user) { create(:user) }
  it { expect(user.name).to eq("#{user.first_name} #{user.last_name}") }

  describe "#admin?" do
    it "is not an admin if the role is not admin" do
      user = FactoryGirl.create(:user, admin: false)
      expect(user.admin?).to eq(false)
    end

    it "is an admin if the role is admin" do
      user = FactoryGirl.create(:user, admin: true)
      expect(user.admin?).to eq(true)
    end
  end
end
