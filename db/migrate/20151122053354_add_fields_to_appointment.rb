class AddFieldsToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :day, :string
    add_column :appointments, :month, :string
    add_column :appointments, :year, :string
  end
end
