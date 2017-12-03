class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :device_name, null: false, default: ""
      t.integer :device_os
      t.inet :device_last_ip
      t.inet :device_current_ip
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :devices, :device_name
  end
end
