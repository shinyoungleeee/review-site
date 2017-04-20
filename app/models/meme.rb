class Meme < ApplicationRecord
  belongs_to :contributor, class_name: "User"

  validates :name, presence: true
  validates :image_url, presence: true

end
