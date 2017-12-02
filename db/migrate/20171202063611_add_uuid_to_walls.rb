class AddUuidToWalls < ActiveRecord::Migration[5.1]
  def change
    add_column :walls, :uuid, :string
  end
end
