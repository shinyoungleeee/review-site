class CreateMemes < ActiveRecord::Migration[5.0]
  def change
    create_table :memes do |t|
      t.string :name, null: false
      t.string :image_url,  null: false
      t.string :description

      t.timestamps
    end
  end
end
