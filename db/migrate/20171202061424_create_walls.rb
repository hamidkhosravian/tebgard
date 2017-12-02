class CreateWalls < ActiveRecord::Migration[5.1]
  def change
    create_table :walls do |t|
      t.boolean :active, default: false
      t.string :doctor_code, null: false
      t.string :description
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
