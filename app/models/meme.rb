class Meme < ApplicationRecord
  belongs_to :contributor, class_name: "User"

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :image_url, presence: true
  validates :contributor_id, presence: true
end
