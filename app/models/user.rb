class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :contributed_memes, foreign_key: "contributor_id", class_name: "Meme"
  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 4, maximum: 16 }
  validates :username, format: { with: /\A(?!.*\.\.)(?!.*\.$)[^\W][\w.]{4,16}\z/,
    message: "can only contain characters a-z, 0-9, underscores and periods" }

  validates :email, presence: true, email: true
  validates :email, uniqueness: true

  validates :encrypted_password, presence: true
  validates :encrypted_password, length: { minimum: 6 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
    first_name + " " + last_name
  end
end
