class RemoveSubsidiaryFromAppointment < ActiveRecord::Migration[6.0]
  def change
    remove_reference :appointments, :subsidiary, null: false, foreign_key: true
  end
end
