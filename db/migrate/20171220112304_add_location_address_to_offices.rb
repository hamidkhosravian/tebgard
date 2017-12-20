class AddLocationAddressToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :location_address, :string
  end
end
