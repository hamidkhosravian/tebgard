class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.references :office, foreign_key: true
      t.references :profile, foreign_key: true
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
