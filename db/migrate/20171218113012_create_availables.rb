class CreateAvailables < ActiveRecord::Migration[5.1]
  def change
    create_table :availables do |t|
      t.boolean :status, default: false
      t.date :date
      t.time :start_time
      t.time :end_time
      t.references :availability, polymorphic: true, index: true

      t.timestamps
    end
  end
end
