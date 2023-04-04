class CreateWines < ActiveRecord::Migration[6.1]
  def change
    create_table :wines do |t|
      t.integer :member_id, null: false
      t.integer :genre_id, null: false
      t.integer :spot_id
      t.string :wine_name
      t.string :production_country
      t.string :production_year
      t.float :rate
      t.text :impression
      t.boolean :is_again, default: false, null: false
      t.timestamps
    end
  end
end
