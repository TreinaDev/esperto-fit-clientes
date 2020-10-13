class RemovePaymentOptionsFromEnroll < ActiveRecord::Migration[6.0]
  def change
    remove_column :enrolls, :payment_option, :string
  end
end
