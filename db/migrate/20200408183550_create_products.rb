class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :url
      t.string :title
      t.string :description
      t.decimal :price
      t.string :image_url
      t.string :mobile_number
      t.integer :user_id
      t.datetime :refreshed_at

      t.timestamps
    end
  end
end
