class AddContributorIdToMemes < ActiveRecord::Migration[5.0]
  def change
    add_column :memes, :contributor_id, :integer, null: false
  end
end
