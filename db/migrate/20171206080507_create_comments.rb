class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
      t.references :wall, foreign_key: true, index: true
      t.string     :body
      t.string :uuid
      
      t.timestamps
    end
  end
end
