RSpec.describe ReviewVote, type: :model do
  subject { create(:review_vote) }
  it { should validate_uniqueness_of(:user).scoped_to(:review_id) }
  it { should belong_to(:user) }
  it { should belong_to(:review) }
end
