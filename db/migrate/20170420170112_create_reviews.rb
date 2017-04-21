class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.integer :votes, default: 0

      t.string :body

      t.belongs_to :meme
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
