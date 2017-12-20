class CreateOpenDays < ActiveRecord::Migration[5.1]
  def change
    create_table :open_days do |t|
      t.references :office, foreign_key: true
      t.integer :day

      t.timestamps
    end
  end
end
