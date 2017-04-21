class RemoveVotesColumnFromReviews < ActiveRecord::Migration[5.0]
  def up
    remove_column :reviews, :votes
  end
  def down
    add_column :reviews, :votes, :integer, default: 0
  end
end
