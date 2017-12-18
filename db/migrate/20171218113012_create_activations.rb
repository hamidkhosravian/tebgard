class CreateActivations < ActiveRecord::Migration[5.1]
  def change
    create_table :activations do |t|
      t.boolean :status, default: true
      t.date :date
      t.time :start_time
      t.time :end_time
      t.references :activable, polymorfic: true

      t.timestamps
    end
  end
end
