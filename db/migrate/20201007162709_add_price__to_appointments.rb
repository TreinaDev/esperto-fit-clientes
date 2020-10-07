class AddPriceToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :price_per_hour, :float
  end
end
