class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.references :wall, foreign_key: true
      t.text :body
      t.string :uuid

      t.timestamps
    end
  end
end
