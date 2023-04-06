class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.string :spot_name
      t.string :address
      t.string :telephone_number
      t.float :lat
      t.float :lng
      t.timestamps
    end
  end
end
