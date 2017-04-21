class CreateVotesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :review_votes do |t|
      t.belongs_to :review
      t.boolean :upvote, default: false
      t.boolean :downvote, default: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
