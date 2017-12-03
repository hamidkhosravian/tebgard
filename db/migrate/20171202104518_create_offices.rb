class CreateOffices < ActiveRecord::Migration[5.1]
  def change
    create_table :offices do |t|
      t.float :latitude
      t.float :longitude
      t.string :office_phone_number
      t.string :address
      t.references :wall, foreign_key: true

      t.timestamps
    end
  end
end
