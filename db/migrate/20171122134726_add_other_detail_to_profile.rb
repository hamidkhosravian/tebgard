class AddOtherDetailToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :phone, :string
    add_column :profiles, :birthdate, :date
    add_column :profiles, :email, :string
  end
end
