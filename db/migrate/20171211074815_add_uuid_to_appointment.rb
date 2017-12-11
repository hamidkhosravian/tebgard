class AddUuidToAppointment < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :uuid, :uuid
  end
end
