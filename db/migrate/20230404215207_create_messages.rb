class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :user_name
      t.string :first_name
      t.string :text
      t.integer :user_id
      t.text :image_url

      t.timestamps
    end
    add_index :messages, :user_id
  end
end
