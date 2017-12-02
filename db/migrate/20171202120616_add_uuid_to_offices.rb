class AddUuidToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :uuid, :string
  end
end
