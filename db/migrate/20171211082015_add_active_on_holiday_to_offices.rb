class AddActiveOnHolidayToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :holiday_activation, :boolean, default: false
  end
end
