class AddDescriptionToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :description, :string
  end
end
