require 'rails_helper'

RSpec.describe Meme, type: :model do
  subject { create(:meme) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:image_url) }
  it { should validate_presence_of(:contributor_id) }
  it { should belong_to(:contributor) }
  it { should have_many(:reviews) }
end
