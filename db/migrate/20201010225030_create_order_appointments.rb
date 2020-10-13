class CreateOrderAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :order_appointments do |t|
      t.references :client, null: false, foreign_key: true
      t.references :appointment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
