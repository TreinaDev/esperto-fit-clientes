class CreateOrderSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :order_schedules do |t|

      t.timestamps
    end
  end
end
