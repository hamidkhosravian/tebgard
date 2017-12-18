class AddDescriptionToActivations < ActiveRecord::Migration[5.1]
  def change
    add_column :activations, :description, :string
  end
end
