class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|

      t.timestamps null: false
    end
  end
end
