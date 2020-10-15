class AddCouponToEnroll < ActiveRecord::Migration[6.0]
  def change
    add_column :enrolls, :coupon, :string
  end
end
