class AddFieldToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :comment, :text
  end
end
