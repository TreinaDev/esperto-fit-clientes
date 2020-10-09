class CreateEnrolls < ActiveRecord::Migration[6.0]
  def change
    create_table :enrolls do |t|
      t.integer :subsidiary_id
      t.integer :plan_id
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
