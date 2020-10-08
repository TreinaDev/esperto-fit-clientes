class AddPaymentOptionToEnroll < ActiveRecord::Migration[6.0]
  def change
    add_column :enrolls, :payment_option, :string
  end
end
