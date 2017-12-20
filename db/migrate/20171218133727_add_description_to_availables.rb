class AddDescriptionToAvailables < ActiveRecord::Migration[5.1]
  def change
    add_column :availables, :description, :string
  end
end
