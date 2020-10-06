class CreatePersonalSubsidiaries < ActiveRecord::Migration[6.0]
  def change
    create_table :personal_subsidiaries do |t|
      t.references :personal, null: false, foreign_key: true
      t.string :subsidiary_id

      t.timestamps
    end
  end
end
