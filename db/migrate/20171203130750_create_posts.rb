class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :wall, foreign_key: true
      t.string :body
      t.string :uuid

      t.timestamps
    end
  end
end
