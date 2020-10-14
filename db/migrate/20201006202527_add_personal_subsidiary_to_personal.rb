class AddPersonalSubsidiaryToPersonal < ActiveRecord::Migration[6.0]
  def change
    add_reference :personals, :personal_subsidiary, null: true, foreign_key: true
  end
end
