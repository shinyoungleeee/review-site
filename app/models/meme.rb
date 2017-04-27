class Meme < ApplicationRecord
  belongs_to :contributor, class_name: "User"
  has_many :reviews

  has_many :reviews

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :image_url, presence: true

  validates :contributor_id, presence: true

  def self.search(search)
    where("name ILIKE ? ", "%#{search}%")
  end
end
