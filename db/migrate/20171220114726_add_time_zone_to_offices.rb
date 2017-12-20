class AddTimeZoneToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :time_zone, :string
  end
end
