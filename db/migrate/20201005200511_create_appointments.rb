class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.time :appointment_time
      t.date :appointment_date
      t.references :subsidiary, null: false, foreign_key: true
      t.references :personal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
