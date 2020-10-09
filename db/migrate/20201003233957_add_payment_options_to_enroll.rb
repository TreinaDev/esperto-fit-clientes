class AddPaymentOptionsToEnroll < ActiveRecord::Migration[6.0]
  def change
    add_reference :enrolls, :payment_option, null: false, foreign_key: true
  end
end
