class CreateOpenHours < ActiveRecord::Migration[5.1]
  def change
    create_table :open_hours do |t|
      t.time :open_time
      t.time :close_time
      t.references :open_day, foreign_key: true

      t.timestamps
    end
  end
end
