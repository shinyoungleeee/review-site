class Meme < ApplicationRecord

  has_many :reviews

  validates :name, presence: true
  validates :image_url, presence: true

end
