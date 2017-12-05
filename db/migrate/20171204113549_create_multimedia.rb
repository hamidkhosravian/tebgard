class CreateMultimedia < ActiveRecord::Migration[5.1]
  def change
    create_table :multimedia do |t|
      t.references :multimediable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
