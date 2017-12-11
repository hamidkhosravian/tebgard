class AddDefaultAppointmentDurationToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :appointment_duration, :integer, default: 1800
  end
end
