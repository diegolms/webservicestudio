class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :nome
      t.string :latitude
      t.string :longitude
      t.timestamps null: false
    end
  end
end
